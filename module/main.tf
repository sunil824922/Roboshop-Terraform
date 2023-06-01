

resource "aws_instance" "instance" {

  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow_all.id]

  tags = {
    Name = local.name
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

    inline = var.app_type == "db" ? local.db_commands : local.app_commands
  }
}

resource "aws_route53_record" "records" {

  zone_id = "Z02273062C88PHAGX2U2W"
  name    = "${var.component_name}-dev.devops2023sk.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}


resource "aws_iam_role" "role" {
  name = "${var.component_name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.component_name}-${var.env}-role"
  }
}


resource "aws_iam_policy" "ssm-ps-policy" {
  name = "${var.component_name}-${var.env}-ssm-ps-policy"


  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": "arn:aws:ssm:us-east-1:116420554906:parameter/${var.env}.${var.component_name}*"
      },
      {
        "Sid": "VisualEditor1",
        "Effect": "Allow",
        "Action": "ssm:DescribeParameters",
        "Resource": "*"
      }
    ]
  })
}


