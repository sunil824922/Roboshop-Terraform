module "vpc" {
  source = "https://github.com/sunil824922/tf-module-vpc.git"

  for_each = var.vpc
  cidr_block = each.value["cide_block"]
}
