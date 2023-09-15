job "example-seaweedfs-app" {
  datacenters = ["obs"]

  group "apps" {
    volume "gitlab" {
      type            = "csi"
      source          = "gitlab"
      access_mode     = "single-node-writer"
      attachment_mode = "file-system"
    }

    task "sample" {
      driver = "podman"

      config {
        image      = "docker.io/kadalu/sample-pv-check-app:latest"
        force_pull = false

        entrypoint = [
          "tail",
          "-f",
          "/dev/null",
        ]
      }

      volume_mount {
        volume      = "gitlab"
        destination = "/mnt/pv"
      }
      volume_mount {
        volume      = "gitlab"
        destination = "/mnt/pv2"
      }

    }
  }
}