wget -O packer.zip https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_amd64.zip?_ga=2.172604963.1433869664.1522083868-384145405.1522083868
unzip packer.zip
./packer validate deployments/template.json
./packer build deployments/template.json
