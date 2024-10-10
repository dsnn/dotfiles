resource "dns_a_record_set" "srv_prod_1" {
  zone      = "home.dsnn.io."
  name      = "srv-prod-1"
  addresses = ["10.20.0.2"]
  ttl       = 3600
}

resource "dns_a_record_set" "srv_prod_1_wildcard" {
  zone      = "home.dsnn.io."
  name      = "*.srv-prod-1"
  addresses = ["10.20.0.2"]
  ttl       = 3600
}
