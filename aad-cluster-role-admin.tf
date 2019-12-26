resource "kubernetes_cluster_role_binding" "admin" {
  count = var.rbac_aad_admin == null ? 0 : 1
  metadata {
    name = "cluster-default-admin"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = var.rbac_aad_admin
    api_group = "rbac.authorization.k8s.io"
  }
}