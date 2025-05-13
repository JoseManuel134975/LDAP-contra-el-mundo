output "apache_public_ip" {
  value = aws_instance.apache.public_ip
}

output "ldap_public_ip" {
  value = aws_instance.ldap.public_ip
}
