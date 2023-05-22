

resource "aws_instance" "instance" {

  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = var.env != "" ? "${var.component_name}-${var.env}" : var.component_name
  }
}


resource "null_resource" "provisioner"  {
  depends_on = [aws_instance.instance, aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = [
      "sudo rm -rf roboshop-shell Project-1",
      "sudo git clone https://github.com/sunil824922/Project-1.git",
      "cd Project-1",
      "sudo bash ${var.component_name}.sh ${var.password}"
    ]
  }
}


resource "aws_route53_record" "records" {

  zone_id = "Z02273062C88PHAGX2U2W"
  name    = "${var.component_name}-dev.devops2023sk.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}
