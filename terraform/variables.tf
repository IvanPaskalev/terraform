variable "instance_type" {
  description = "."
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "name"
  type        = string
  default     = "apache-host"
}

# variable "ami-id" {
#   description = "ami-id"
#   type        = string
#   default     = "ami-0d527b8c289b4af7f"
# }

variable "minimum-nodes" {
  description = "min"
  type        = number
  default     = 1
}

variable "maximum-nodes" {
  description = "max"
  type        = number
  default     = 1
}
variable "desired-capacity" {
  description = "..."
  type        = number
  default     = 1
}
