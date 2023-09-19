resource "kubernetes_service" "shopfront" {
metadata {
  name = "shopfront"
  labels = {
    "app" = "shopfront"
  }
}
spec {
  type = "NodePort"
  selector = {
    "app" = "shopfront"
  }
  port {
    protocol = "TCP"
    port = 8010
    name = "http"
  }
}  
}

resource "kubernetes_deployment" "shopfront" {
  metadata {
    name = "shopfront"
  }
  spec {
    selector {
      match_labels = {
        "app" = "shopfront"
      }
    }
    replicas = 1
    template {
      metadata {
        labels = {
          "app" = "shopfront"
        }
      }
      spec {
        container {
          name = "shopfront"
          image = "8209820403/shopfront:latest"
          port {
            container_port = 8010
          }
          liveness_probe {
            http_get {
              path = "/health"
              port = 8010
            }
            initial_delay_seconds = 30
            timeout_seconds = 1
          }
        }
      }
    }
  }
}