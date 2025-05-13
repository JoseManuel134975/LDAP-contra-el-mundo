output "apache_public_ip" {
  value = aws_instance.apache.public_ip
}

output "ldap_private_ip" {
  value = aws_instance.ldap.private_ip
}
