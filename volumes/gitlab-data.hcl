id   = "gitlab-data-vol"
name = "gitlab-data-vol"
type = "csi"

capacity_min = "10GiB"
capacity_max = "10Gib"

capability {
  access_mode     = "multi-node-multi-writer"
  attachment_mode = "file-system"
}
plugin_id = "juicefs0"

secrets {
  name           = "gitlab-data-vol"
  metaurl        = "redis://:DYdyAXAmDH8ePd@mymaster,server1,server2.server3:26379/2"
  bucket         = "http://minio.service.consul:9000/gitlab-data"
  storage        = "minio"
  access-key     = "test"
  secret-key     = "testpassword"
  format-options = "trash-days=0"

}

mount_options {
  mount_flags = ["writeback_cache"]
}
