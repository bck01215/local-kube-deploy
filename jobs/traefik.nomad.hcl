job "traefik" {
  region      = "global"
  datacenters = ["obs"]
  type        = "system"

  group "traefik" {
    count = 1

    network {
      port "http" {
        static = 8080
      }
      port "api" {
        static = 8081
      }
    }


    service {
      name = "traefik"
      check {
        name     = "alive"
        type     = "tcp"
        port     = "http"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "traefik" {
      driver = "podman"

      config {
        image        = "docker.io/traefik:v3.0"
        network_mode = "host"

        volumes = [
          "local/traefik.toml:/etc/traefik/traefik.toml",
        ]
      }

      template {
        data = <<EOF
[entryPoints]
    [entryPoints.http]
    address = ":8080"
    [entryPoints.traefik]
    address = ":8081"

[api]
    dashboard = true
    insecure  = true

# Enable Consul Catalog configuration backend.
[providers.consulCatalog]
    defaultRule = "Host(`{{"{{ normalize .Name }}"}}.service.consul`)"
    prefix           = "traefik"
    exposedByDefault = false
    connectAware = true

    [providers.consulCatalog.endpoint]
      address = "127.0.0.1:8500"
      scheme  = "http"
EOF

        destination = "local/traefik.toml"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}

