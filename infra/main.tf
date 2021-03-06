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
    path = "/"
  }

  droplet_tag = "${digitalocean_tag.platzi.name}"
}

resource "digitalocean_tag" "platzi" {
  name = "platzi"
}

resource "digitalocean_droplet" "platzi-droplet" {
  count     = 2
  image     = "${var.image_id}"
  name      = "platzi-demo-v2"
  region    = "ams3" 
  size      = "512mb"
  ssh_keys  = [19435667]
  tags      = ["${digitalocean_tag.platzi.id}"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 120 && curl ${self.ipv4_address}:3000"
  }

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