locals {
  name = var.env != "" ? "${var.component_name}-${var.env}" : var.component_name
  db_commands = [
    "rm -rf roboshop-shell Project-1",
    "sudo git clone https://github.com/sunil824922/Project-1.git",
    "cd Project-1",
    "sudo bash ${var.component_name}.sh ${var.password}"

  ]

  app_commands = [
#     "sudo labauto ansible",
#     "ansible-pull -i localhost, -U https://github.com/sunil824922/roboshop-ansible.git roboshop.yml -e env=${var.env} -e role_name=${var.component_name}"
      "echo ok"
  ]
}