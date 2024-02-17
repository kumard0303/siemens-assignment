resource "aws_instance" "bastion_host" {
  ami = var.ami
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_az1_id
  vpc_security_group_ids = [var.bastion_sg_id]
  key_name = aws_key_pair.mykeypair.key_name

}

resource "aws_key_pair" "mykeypair" {
  key_name   = "bastion_rsa"
  public_key = file(var.PUBLIC_KEY)
}