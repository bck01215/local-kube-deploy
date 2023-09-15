id   = "gitlab-log-vol"
name = "gitlab-log-vol"
type = "csi"

capacity_min = "5GiB"
capacity_max = "20Gib"

capability {
  access_mode     = "multi-node-multi-writer"
  attachment_mode = "file-system"
}

plugin_id = "juicefs0"

secrets {
  name       = "gitlab-log-vol"
  metaurl    = "redis://:DYdyAXAmDH8ePd@mymaster,server1,server2.server3:26379/3"
  bucket     = "http://minio.service.consul:9000/gitlab-log"
  storage    = "minio"
  access-key = "test"
  secret-key = "testpassword"
}