variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0149b2da6ceec4bb0"
  }
}

variable "USER" {
  default = "ubuntu"
}

variable "PUB_KEY" {
  default = "emby.pub"
}

variable "PRIV_KEY" {
  default = "emby"
}

variable "MYANYWHERE" {
  default = "0.0.0.0/0"
}