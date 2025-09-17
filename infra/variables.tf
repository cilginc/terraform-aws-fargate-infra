variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-1"
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "myapp"
}

variable "app_image" {
  description = "Docker image for ECS task"
  type        = string
}

variable "cpu" {
  default = 256
}

variable "memory" {
  default = 512
}

variable "container_port" {
  type = number
}

variable "host_port" {
  default = 80
  type = number
}
