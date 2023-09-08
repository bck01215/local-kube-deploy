job "seaweedfs-csi" {
  datacenters = ["obs"]
  region      = "global"
  type        = "system"

  update {
    max_parallel = 1
    stagger      = "60s"
  }

  group "nodes" {

    ephemeral_disk {
      migrate = false
      size    = 10240
      sticky  = false
    }

    task "plugin" {
      driver = "podman"

      config {
        image        = "docker.io/chrislusf/seaweedfs-csi-driver:v1.1.8"
        network_mode = "host"

        args = [
          "--endpoint=unix://csi/csi.sock",
          "--filer=weed-filer.service.consul:8888",
          "--nodeid=${node.unique.name}",
          "--cacheCapacityMB=256",
          "--cacheDir=${NOMAD_TASK_DIR}/cache_dir",
        ]

        privileged = true
      }

      csi_plugin {
        id        = "seaweedfs"
        type      = "monolith"
        mount_dir = "/csi"
      }

      resources {
        cpu        = 512
        memory     = 1024
        memory_max = 3072 # W need to have memory oversubscription enabled
      }
    }
  }
}