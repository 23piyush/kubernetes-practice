resource "kubernetes_deployment" "productcatalogue" {
  metadata {
    name = "productcatalogue"
  }
  spec {
    selector {
      match_labels = {
        "app" = "productcatalogue"
      }
    }
    replicas = 1
    template {
      metadata {
        labels = {
          "app" = "productcatalogue"
        }
      }
      spec {
        container {
          name = "productcatalogue"
          image = "8209820403/productcatalogue:latest"
          port {
            container_port = 8020
          }
          liveness_probe {
            http_get {
              path = "/healthcheck"
              port = 8025
            }
            initial_delay_seconds = 30
            timeout_seconds = 1
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "productcatalogue" {
  metadata {
    name = "productcatalogue"
    labels = {
      "app" = "productcatalogue"
    }
  }
  spec {
    type = "NodePort"
    selector = {
      "app" = "productcatalogue"
    }
    port {
      protocol = "TCP"
      port = 8020
      name = "http"
    }

  }
}