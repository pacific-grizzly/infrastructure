resource "aws_vpc" "staging" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "staging"
  }
}
