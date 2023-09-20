resource "kubernetes_ingress" "demo_app_ingress" {
  metadata {
    name = "demo-app-ingress"
  }
  spec {
    rule {
      host = "minikube-example.com"
      http {
        path {
          path = "/products"
          backend {
            service_name = "productcatalogue"
            service_port = "8020"
          }
        }
        path {
          path = "/"
          backend {
            service_name = "shopfront"
            service_port = "8010"
          }
        }
        path {
          path = "/stocks"
          backend {
            service_name = "stockmanager"
            service_port = "8030"
          }
        }
      }
    }
  }
}