resource "kubernetes_service" "stockmanager" {
  metadata {
    name = "stockmanager"
    labels = {
      "app" = "stockmanager"
    }
  }
  spec {
    type = "NodePort"
    selector = {
      "app" = "stockmanager"
    }
    port {
      protocol = "TCP"
      port = 8030
      name = "http"
    }
  }
}

resource "kubernetes_deployment" "stockmanager" {
  metadata {
    name = "stockmanager"
  }
  spec {
    selector {
      match_labels = {
        "app" = "stockmanager"
      }
    }
    replicas = 1
    template {
      metadata {
        labels = {
          "app" = "stockmanager"
        }
      }
      spec {
        container {
          name = "stockmanager"
          image = "8209820403/stockmanager:latest"
          port {
            container_port = 8030
          }
          liveness_probe {
            http_get {
              path = "/health"
              port = 8030
            }
            initial_delay_seconds = 30
            timeout_seconds = 1
          }
        }
      }
    }
  }
}