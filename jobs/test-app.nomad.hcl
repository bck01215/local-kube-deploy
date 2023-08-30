job "countdash" {
  datacenters = ["obs"]

  group "api" {
    network {
      mode = "bridge"
    }

    service {
      name = "count-api"
      port = "9001"

      connect {
        sidecar_service {}
      }
    }

    task "web" {
      driver = "podman"

      config {
        image = "docker.io/hashicorpdev/counter-api:v3"
      }
    }
  }

  group "dashboard" {
    network {
      mode = "bridge"

    }

    service {
      name = "count-dashboard"
      port = 9002
      tags = [
        "traefik.enable=true",
        "traefik.consulcatalog.connect=true",
#        "traefik.http.routers.count-dashboard.rule=Host(`test.obs.com`)",
      ]
      connect {
        sidecar_service {
          tags = []
          proxy {
            upstreams {
              destination_name = "count-api"
              local_bind_port  = 8080
            }
          }
        }
      }
    }

    task "dashboard" {
      driver = "podman"

      env {
        COUNTING_SERVICE_URL = "http://${NOMAD_UPSTREAM_ADDR_count_api}"
      }

      config {
        image = "docker.io/hashicorpdev/counter-dashboard:v3"
      }
    }
  }
}
