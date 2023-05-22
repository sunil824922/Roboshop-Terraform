

module "servers" {
  for_each = component
  source = "./module"
  component_name = each.value["name"]
  env =  "var.env"
  instance_type = each.value["instance_type"]
  password = lookup(each.value, "password", "null")
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