variable "region" {
  default = "eu-west-2"
}

# NOTE: the lab uses t2.micro. On this AWS account t2.micro is no longer
# Free Tier eligible, so t3.micro (Free Tier eligible) is used instead.
variable "instance_type" {
  default = "t3.micro"
}

# Amazon Linux 2 AMI (HVM, x86_64, gp2) - eu-west-2 (London)
variable "instance_ami" {
  default = "ami-01dfd9fb3a7b119e0"
}


variable "vpc_id" {
  default = ""
}


variable "key_name" {
  default = "cba-akosa-keypair"
}
