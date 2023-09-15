job "jfs-controller" {
  datacenters = ["obs"]
  type        = "system"

  group "controller" {
    task "plugin" {
      driver = "podman"

      config {
        image = "docker.io/juicedata/juicefs-csi-driver:v0.22.1"

        args = [
          "--endpoint=unix://csi/csi.sock",
          "--logtostderr",
          "--nodeid=test",
          "--v=5",
          "--by-process=true"
        ]

        privileged = true
      }

      csi_plugin {
        id        = "juicefs0"
        type      = "controller"
        mount_dir = "/csi"
      }
      resources {
        cpu    = 100
        memory = 512
      }
      env {
        POD_NAME = "csi-controller"
      }
    }
  }
}