

variable "instance_type" {
  default = "t3.micro"
}

resource "aws_instance" "instance" {
  for_each         = var.components
  ami           = data.aws_ami.centos.image_id
  instance_type = each.value ["instance_type"]
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = each.value["name"]
  }
}


resource "aws_route53_record" "records" {
  for_each = var.components
  zone_id = "Z02273062C88PHAGX2U2W"
  name    = "${each.value["name"]}.devops2023sk.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance[each.value["name"]].private_ip]
}


#

#
#resource "aws_instance" "mongodb" {
#  ami           = data.aws_ami.centos.image_id
#  instance_type = "t3.micro"
#  vpc_security_group_ids = [data.aws_security_group.allow-all.id]
#  tags = {
#    Name = "mongodb"
#  }
#}
#resource "aws_route53_record" "mongodb" {
#  zone_id = "Z07723241NASCD733XBTT"
#  name    = "mongodb-dev.devops2023sk.online"
#  type    = "A"
#  ttl     = 30
#  records = [aws_instance.mongodb.private_ip]
#}