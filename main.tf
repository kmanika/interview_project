module "web_app_module" {
  source = "./app-component"
  ami                       = "ami-09d3b3274b6c5d4aa"
  instance_type             = "t2.micro"
}