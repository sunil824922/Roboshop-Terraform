
components = {

  frontend = {
    name = "frontend"
    instance_type = "t3.small"
  }
  mongodb = {
    name = "mongodb"
    instance_type = "t3.micro"
  }
  catalogue = {
    name = "catalogue"
    instance_type = "t3.small"
  }
  payment = {
    name          = "payment"
    instance_type = "t3.small"
  }
}

env = "dev"