id   = "gitlab-config-vol"
name = "gitlab-config-vol"
type = "csi"

capacity_min = "2GiB"
capacity_max = "2Gib"

capability {
  access_mode     = "multi-node-multi-writer"
  attachment_mode = "file-system"
}


plugin_id = "juicefs0"

secrets {
  name       = "gitlab-config-vol"
  metaurl    = "redis://:pass@mymaster,server1,server2.server3:26379/1"
  bucket     = "http://minio.service.consul:9000/gitlab-config"
  storage    = "minio"
  access-key = "test"
  secret-key = "testpassword"
}