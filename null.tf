resource "null_resource" "cluster" {
  count = "${var.environment == "dev" ? 3 : 1}"
 provisioner "local-exec" {
    command = <<EOH
     echo "{element(aws_instance.public-instances.*.public_ip, count.index)}" >> details && echo "{element(aws_instance.public-instance.*.pravate.ip, count.index)}" >> details,
      EOH
 } 
 
}      
