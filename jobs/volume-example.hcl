job "example-seaweedfs-app" {
  datacenters = ["obs"]

  group "apps" {
    volume "example-seaweedfs-volume" {
      type            = "csi"
      source          = "example-seaweedfs-volume"
      access_mode     = "multi-node-multi-writer"
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
        volume = "example-seaweedfs-volume"
        destination = "/mnt/pv"
      }
    }
  }
}