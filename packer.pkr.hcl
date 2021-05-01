
variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "build_name" {
  type    = string
  default = "terraform"
}

variable "git_sha" {
  type    = string
  default = "none"
}

variable "profile" {
  type    = string
  default = "terraform"
}

data "amazon-ami" "ubuntu-focal" {
  filters = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  profile     = "terraform"
  region      = "us-east-1"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "ubuntu-base" {
  profile               = "terraform"
  region                = "us-east-1"
  ami_name              = "ubuntu-base-${var.git_sha}"
  instance_type         = "t2.micro"
  source_ami            = "${data.amazon-ami.ubuntu-focal.id}"
  ssh_username          = "ubuntu"
  force_deregister      = true
  force_delete_snapshot = true
  tags = {
    Name     = "ubuntu-base"
    Revision = var.git_sha
    Role     = "base"
  }
  snapshot_tags = {
    Name     = "ubuntu-base"
    Revision = var.git_sha
    Role     = "base"
  }
}

build {

  sources = ["source.amazon-ebs.ubuntu-base"]

  provisioner "shell" {
    pause_before = "4s"
    scripts      = ["./provision/base.sh"]
  }

}
