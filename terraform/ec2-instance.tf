resource "aws_instance" "apache" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = "${var.aws_region}a"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_instance_ports.id]
  user_data              = file("user_data_apache.sh")
  key_name = aws_key_pair.debian.key_name

  tags = {
    Name = "Debian-apache"
  }
}

resource "aws_instance" "ldap" {
  ami               = var.ami_id
  instance_type     = var.instance_type
  availability_zone = "${var.aws_region}a"
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.allow_instance_ports.id]
  user_data              = file("user_data_ldap.sh")
  key_name = aws_key_pair.debian.key_name
  private_ip = var.private_ip

  tags = {
    Name = "Debian-ldap"
  }
}