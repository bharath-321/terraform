resource "aws_instance" "public-instance" {
  count = "${var.environment == "dev" ? 3 : 1}"
  ami = "${lookup(var.amis, var.aws_region, "us-east-1")}"
  #ami = "ami-0d857ff0f5fc4e03b"
  #availability_zone           = "us-east-1a"
  instance_type               = "t2.micro"
  key_name                    = "vasireddy22"
  subnet_id                   = "${element(aws_subnet.public-subnets.*.id, count.index)}"
  vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              sudo amazon-linux-extras install epel -y
              sudo yum install stress -y
              sudo amazon-linux-extras install nginx1
              yum install -y nginx
              echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
    EOF
  tags = {
     Name       = "publicServer-${count.index+1}"
     Env        = "Prod"
     #Owner      = "Sree"
    #CostCenter = "ABCD"
  }
  
}

#resource "aws_instance" "private-instance" {
 # count = "${var.environment == "dev" ? 3 : 1}"
  #ami = "ami-02e136e904f3da870"
  #ami = "ami-0d857ff0f5fc4e03b"
  #availability_zone           = "us-east-1a"
  #instance_type               = "t2.micro"
  #key_name                    = "vasireddy22"
  #ubnet_id                   = "${element(aws_subnet.private-subnets.*.id, count.index)}"
  #vpc_security_group_ids      = ["${aws_security_group.allow_all.id}"]
  #associate_public_ip_address = true
  #tags = {
     #Name       = "publicServer-${count.index+1}"
     #Env        = "Prod 1"
     #Owner      = "Sree"
    #CostCenter = "ABCD"
  #}
#}