service {
  name = "minio"

  tags = [
    "traefik.enable=true",
    "traefik.consulcatalog.connect=true",
  ]

  check = {
    http     = "http://localhost:9001"
    interval = "15s"
    timeout  = "1s"
  }
  port = 9001
}
