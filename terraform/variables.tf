variable "region" {
  default = "us-east-1"
}

variable "amis" {
  type = "map"
  default = {
    "us-east-1" = "ami-0ac80df6eff0e70b5"
    "us-east-1-red-hat" = "ami-098f16afa9edf40be"
  }
}