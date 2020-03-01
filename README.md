# Enterprise-ready Azure Kubernetes Service Module

This module creates an Azure Kubernetes Service with default options ready for enterprise deployments, including:

* Azure CNI
* Calico Network Policy
* Node auto-scaler
* Role-based access control enabled by default
* Optional Azure Active Directory RBAC (+ Azure AD application setup script)

## How to use

This module can make your life easier, but please read how to use it carefully:

### Plan your IP Address needs

This [Microsoft Docs](https://docs.microsoft.com/en-us/azure/aks/configure-azure-cni#plan-ip-addressing-for-your-cluster) contains everything you should do in terms of IP planning.

By default, this module has been planned in the following way:

* Pods per node: 60
* Max nodes supported by the VNET: 133
* Max pods: 60 * 133 = 7980
* VNET CIDR: 172.16.0.0/18 (16,382 usable hosts)
  * Cluster subnet: 172.16.0.0/19 (8190 usable hosts / Nodes / Pods / External Load Balancers)
  * Service subnet: 172.16.32.0/19 (8190 usable hosts / Services)  

### Request Azure Active Directory

Most companies don't give admin rights over AzureAD to a Service Principal. This module assumes you should request the following to your Cloud Management:

1. (Required) Cluster Service Principal: The SP that runs the cluster
2. (Optional) Azure Active Direcgtory application to enable Azure AD Role-Based Access Control (RBAC)

### Use this module

Please note that the resource group for this AKS should exist. The module won't create it for you.

#### Deploy a cluster with Kubernetes RBAC

The following module definition creates an AKS cluster with the following features:

| Feature                   | Value                                         |
| ------------------------- | --------------------------------------------- |
| Kubernetes                | 1.15.1                                        |
| Role-based Access Control | Yes (Kubernetes)                              |
| Network plugin            | Azure                                         |
| Network policy            | Calico                                        |
| Virtual Machine Size      | Standard_DS3_v2 (4 cores, 16 GB RAM)          |
| Auto-scaler               | Yes (Min 2, Max 16) - Up to 64 cores, 256 RAM |
| VNET Address space        | 10.0.0.0/21                                   |
| VNET NSG                  | Yes (Ingress)                                 |
| Subnets                   | 3 subnets                                     |
| Kubernetes Dashboard      | No                                            |

```tf
module "kubernetes" {
  source      = "cloudcommons/kubernetes/azure"
  version     = "0.1.0"
name                       = "akstest"
location                   = "westeurope"
resource_group             = "terraform-aks-test"
app                        = "aksapp"
kubernetes_version         = "1.15.5"
client_id                  = "00000000-0000-0000-0000-000000000000"
client_secret              = "00000000000000000000000000000000"
linux_ssh_key              = "0000000000000000000000000000000000000000="
}
```

#### Deploy a cluster with Azure AD RBAC

| Feature                   | Value                                         |
| ------------------------- | --------------------------------------------- |
| Kubernetes                | 1.15.1                                        |
| Role-based Access Control | Yes (Azure Active Directory)                  |
| Network plugin            | Azure                                         |
| Network policy            | Calico                                        |
| Virtual Machine Size      | Standard_DS3_v2 (4 cores, 16 GB RAM)          |
| Auto-scaler               | Yes (Min 2, Max 16) - Up to 64 cores, 256 RAM |
| VNET Address space        | 10.0.0.0/21                                   |
| VNET NSG                  | Yes (Ingress)                                 |
| Subnets                   | 3 subnets                                     |
| Kubernetes Dashboard      | No                                            |

```tf
module "kubernetes" {
  source      = "cloudcommons/kubernetes/azure"
  version     = "0.1.0"
name                       = "akstest"
location                   = "westeurope"
resource_group             = "terraform-aks-test"
app                        = "aksapp"
kubernetes_version         = "1.15.5"
client_id                  = "00000000-0000-0000-0000-000000000000"
client_secret              = "00000000000000000000000000000000"
linux_ssh_key              = "0000000000000000000000000000000000000000="
rbac_enabled               = true
rbac_aad                   = true
rbac_aad_client_app_id     = "00000000000000000000000000000000"
rbac_aad_server_app_secret = "00000000000000000000000000000000"
rbac_aad_server_app_id     = "00000000000000000000000000000000"
rbac_aad_admin             = "admin@contoso.com"
}
```
