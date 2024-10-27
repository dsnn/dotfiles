resource "dns_a_record_set" "dns" {
  zone = "home.dsnn.io."
  name = var.name
  addresses = [ var.ipv4 ]
  ttl = 300
}
