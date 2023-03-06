image:
  repository: ${image_repository}
  pullPolicy: Always
  tag: ${image_tag}
podSecurityContext:
  fsGroup: 2000
securityContext:
  capabilities:
    drop:
    - ALL
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  runAsUser: 1000
  allowPrivilegeEscalation: false
resources:
  limits:
    cpu: 100m
    memory: 128Mi
  requests:
    cpu: 5m
    memory: 10Mi
volumes:
  - name: scripts
    configMap:
      name: ${configmap_name}
      defaultMode: 0777
volumeMounts:
  - name: scripts
    mountPath: /scripts
    readOnly: true
serviceMonitor:
  enabled: true
config: |
  scripts:
%{ for script in scripts_list ~}
    - name: ${split(".",script)[0]}
      command: /scripts/${script}
%{ endfor ~}
