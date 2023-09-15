job "jfs-node" {
  datacenters = ["obs"]
  type        = "system"

  group "nodes" {
    task "juicefs-plugin" {
      driver = "podman"

      config {
        image = "docker.io/juicedata/juicefs-csi-driver:v0.22.1"

        args = [
          "--endpoint=unix://csi/csi.sock",
          "--logtostderr",
          "--v=5",
          "--nodeid=test",
          "--by-process=true",
        ]

        privileged = true
      }

      csi_plugin {
        id        = "juicefs0"
        type      = "node"
        mount_dir = "/csi"
      }
      resources {
        cpu    = 1000
        memory = 1024
      }
      env {
        POD_NAME = "csi-node"
      }
    }
  }
}