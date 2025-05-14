# Variable definida
variable "aws_region" {
  description = "AWS region"
  type = string
}

variable "ami_id" {
  description = "ID de la AMI para la/las instancia/as"
  type = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2 (gratuita)"
  type = string
}

# Credenciales AWS
variable "access_key" {
  description = "Clave de acceso para AWS"
  type = string
}

variable "secret_key" {
  description = "Clave secreta para AWS"
  type = string
}

variable "session_token" {
  description = "Token de sesión que expira cada cierto tiempo para AWS"
  type = string
}

variable "private_ip" {
  description = "IP privada para LDAP"
  type = string
}