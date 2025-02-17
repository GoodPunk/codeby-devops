variable  "vpc_subnet_list" {
  description = "List of subnets"
  type        = list(string)
 
}
variable "target_zone" {
  description = "zone"
  type        = string
  default     = "ru-central1-a"
}