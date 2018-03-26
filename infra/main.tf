# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "$DIGITALOCEAN_TOKEN"
}

resource "digitalocean_loadbalancer" "platzi-lb" {
  name = "platzi-lb"
  region = "ams3"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 3000
    target_protocol = "http"
  }

  healthcheck {
    port = 3000
    protocol = "http"
  }

  droplet_tag = "${digitalocean_tag.platzi_tag.name}"
}

resource "digitalocean_tag" "platzi_tag" {
  name = "platzi-fun"
}

resource "digitalocean_droplet" "platzi-droplet" {
  count     = 5
  image     = "32921512"
  name      = "platzi-demo-v2"
  region    = "ams3"
  size      = "512mb"
  ssh_keys  = [19435667]
  tags      = ["${digitalocean_tag.platzi_tag.id}"]
  user_data = <<EOF
#cloud-config
coreos:
  units:
    - name: "platzi.service"
      command: "start"
      content: |
        [Unit]
        Description=Platzi Demo
        After=docker.service

        [Service]
        ExecStart=/usr/bin/docker run -d -p 3000:3000 platzi
  EOF
}