resource "kubernetes_config_map" "main" {
  metadata {
    name      = "scripts"
    namespace = var.namespace
  }
  data = {
    for f in var.scripts :
    f.name => f.data
  }
}

resource "helm_release" "main" {
  name        = "script-exporter"
  namespace   = var.namespace
  repository  = "https://ricoberger.github.io/helm-charts"
  timeout     = 240
  version     = var.chart_version
  chart       = "script-exporter"
  max_history = 10
  values = [templatefile("${path.module}/files/values.yaml.tpl", {
    scripts_list     = var.scripts_list,
    image_tag        = var.image_tag,
    image_repository = var.image_repository,
    configmap_name   = kubernetes_config_map.main.metadata[0].name
    environment      = var.environment
    domain           = var.domain
    game             = var.game
  })]
}

resource "kubernetes_manifest" "main" {
  for_each = toset(var.scripts_list)
  manifest = yamldecode(<<-EOF
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    app: script-exporter
    func: ${split(".", each.key)[0]}
    release: monitoring
  name: script-exporter-${split(".", each.key)[0]}
  namespace: ${var.namespace}
spec:
  endpoints:
    - honorLabels: true
      interval: 30s
      path: /probe
      params:
        script: 
          - ${split(".", each.key)[0]}
      port: http
      scrapeTimeout: 30s
  jobLabel: script-exporter
  namespaceSelector:
    matchNames:
      - ${var.namespace}
  selector:
    matchLabels:
      app.kubernetes.io/instance: script-exporter
  EOF
  )
}


resource "kubernetes_network_policy" "main" {
  metadata {
    name      = "script-exporter"
    namespace = var.namespace
  }

  spec {
    pod_selector {
      match_labels = {
        "app.kubernetes.io/instance" = "script-exporter"
      }
    }
    ingress {
      ports {
        port     = "9469"
        protocol = "TCP"
      }
      from {
        namespace_selector {
          match_labels = {
            name = "monitoring"
          }
        }
        pod_selector {
          match_labels = {
            "app.kubernetes.io/instance" = "monitoring-kube-prometheus-prometheus"
          }
        }
      }
    }
    policy_types = ["Ingress"]
  }
}
