resource "dns_a_record_set" "docker" {
  zone = "home.dsnn.io."
  name = "docker"
  addresses = [
    "192.168.2.110"
  ]
  ttl = 300
}

resource "dns_a_record_set" "docker-wildcard" {
  zone = "home.dsnn.io."
  name = "*.docker"
  addresses = [
    "192.168.2.110"
  ]
  ttl = 300
}

