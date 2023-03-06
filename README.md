<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.9 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.16 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.9 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 2.16 |

## Resources

| Name | Type |
|------|------|
| [helm_release.main](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_config_map.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_manifest.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_network_policy.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/network_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | script exporter chart version | `string` | `"0.3.0"` | no |
| <a name="input_image_repository"></a> [image\_repository](#input\_image\_repository) | script exporter image repository | `string` | `"ricoberger/script_exporter"` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | script exporter image tag | `string` | `"v2.8.0"` | no |
| <a name="input_scripts"></a> [scripts](#input\_scripts) | scripts to run in the exporter | `any` | n/a | yes |
| <a name="input_scripts_list"></a> [scripts\_list](#input\_scripts\_list) | list of scripts | `list(any)` | n/a | yes |
<!-- END_TF_DOCS -->