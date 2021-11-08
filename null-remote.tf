resource "null_resource" "filecopy" {
count = "${var.environment == "dev" ? 3 : 1}"
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("vasireddy22.pem")
      host        = element(aws_subnet.public-subnets.*.id, count.index)
    }
  }
 provisioner "remote-exec" {
    inline = [
      #"chmod +x /tmp/script.sh",
      #"sudo bash /tmp/script.sh",
      "sudo yum update -y",
      "sudo yum install nginx -y",
      "sudo service nginx start"

      ]
    connection {
    type     = "ssh"
    user     = "ec2-user"
    #password = "India@123456"
    private_key = "${file("vasireddy22.pem")}"
    host     = element(aws_subnet.public-subnets.*.id, count.index)
    }
    }
}


