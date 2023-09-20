job "gitlab" {
  datacenters = ["obs"]

  group "gitlab" {
    volume "gitlab-data" {
      type            = "csi"
      source          = "gitlab-data-vol"
      access_mode     = "multi-node-multi-writer"
      attachment_mode = "file-system"
      mount_options {
        mount_flags = ["writeback_cache"]
      }

    }
    volume "gitlab-logs" {
      type            = "csi"
      source          = "gitlab-log-vol"
      access_mode     = "multi-node-multi-writer"
      attachment_mode = "file-system"
      mount_options {
        mount_flags = ["writeback_cache"]
      }

    }
    volume "gitlab-config" {
      type            = "csi"
      source          = "gitlab-config-vol"
      access_mode     = "multi-node-multi-writer"
      attachment_mode = "file-system"
      mount_options {
        mount_flags = ["writeback_cache"]
      }

    }
    network {
      mode = "bridge"
    }
    service {
      name = "gitlab"
      port = 80


      tags = [
        "traefik.enable=true",
        "traefik.consulcatalog.connect=true",
      ]

      connect {
        sidecar_task {
          config {
            privileged = true
          }
        }

        sidecar_service {}
      }
    }

    task "gitlab" {
      resources {
        cpu    = 2048
        memory = 7000
      }
      driver = "podman"
      config {
        image      = "docker.io/gitlab/gitlab-ce:16.2.6-ce.0"
        privileged = true

      }

      env {
        // HTTPS_PROXY           = "http://squidproxy.liberty.edu:3128"
        // HTTP_PROXY            = "http://squidproxy.liberty.edu:3128"
        // NO_PROXY              = "drone.occ.liberty.edu"
        GITLAB_HOST      = "http://gitlab.service.consul"
        GITLAB_LOG_LEVEL = "debug"

        GITLAB_OMNIBUS_CONFIG = <<EOT
        external_url 'http://gitlab.service.consul'
        gitlab_rails['gitlab_shell_ssh_port'] = 8022
        nginx['listen_port'] = 80
        nginx['redirect_http_to_https'] = false
        gitlab_shell['log_level'] = 'DEBUG'
        EOT
      }
      volume_mount {
        volume      = "gitlab-data"
        destination = "/var/opt/gitlab"
      }
      volume_mount {
        volume      = "gitlab-logs"
        destination = "/var/log/gitlab"
      }
      volume_mount {
        volume      = "gitlab-config"
        destination = "/etc/gitlab"
      }
    }
  }
}