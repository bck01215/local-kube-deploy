service {
  name = "weed-filer"

  tags = [
    "traefik.enable=true",
    "traefik.consulcatalog.connect=true",
  ]

  check = {
    http     = "http://localhost:8888"
    interval = "15s"
    timeout  = "1s"
  }
  port = 8888
}
