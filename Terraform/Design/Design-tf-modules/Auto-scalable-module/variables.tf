#--------------------------------Launch Template ----------------------------------#


# AMI

variable "AMI_name" {
  description     = "Give AMI Name"
  type            = string
  default         = "Dev-Fronted-AMI" 
}
variable "AMI_Instance_ID" {
  description     = "Give Dev-Frontend Instance ID"
  type            = string
  default         = "i-0572a5faad61b261e"  # Dev-Frontend Instance ID
}

# Key Generate

variable "private_key_algorithm" {
  description = "value"
  type = string
  default = "RSA"
}
variable "private_key_rsa_bits" {
  description = "value"
  type = number
  default = 4096
}

# Launch Template 

variable "template_name" {
  description     = "Launch Template Name"
  type            = string
  default         = "Dev-Frontend-template"  
}
variable "template_description" {
  description     = "Launch Template Description"
  type            = string
  default         = "Template for Dev-Frontend"  
}
variable "instance_type" {
  description     = "Launch Template Instance Type"
  type            = string
  default         = "t2.micro"  
}
variable "instance_keypair" {
  description     = "Launch Template Instance Type keypair name"
  type            = string
  default         = "Dev_Key"  
}
variable "security_group" {
  description     = "security_groups of Dev-Frontend-sg"
  type            = string
  default         = "sg-0c6b3e33e9b94f694"   // Dev-Frontend-sg
}
variable "subnet_ID" {
  description     = "Launch Template Subnet ID"
  type            = string
  default         = "subnet-04c0c823118f48202"  
}
#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
#--------------------------------- Target Group -----------------------------------#

variable "target_group_name" {
  description     = "Name of the target group"
  type            = string
  default         = "Dev-Frontend-TG"
}
variable "target_group_port" {
  description     = "Port for the target group"
  type            = number 
  default         = 3000
}
variable "target_group_protocol" {
  description     = "Protocol for the target group"
  type            = string
  default         = "HTTP"
}
variable "TG_vpc_id" {
  description     = "ID of the VPC"
  type            = string
  default         = "vpc-0383f4dc3af051efa"    #  Dev-VPC ID 
}
variable "health_check_path" {
  description     = "The destination for the health check request"
  type            = string
  default         = "/health"
}
variable "health_check_port" {
  description     = "The port to use to connect with the target for health checking"
  type            = string
  default         = "traffic-port"
}
variable "health_check_interval" {
  description     = "The approximate amount of time, in seconds, between health checks of an individual target"
  type            = number
  default         = 30
}
variable "health_check_timeout" {
  description     = "The amount of time, in seconds, during which no response means a failed health check"
  type            = number
  default         = 5
}
variable "health_check_healthy_threshold" {
  description     = "The number of consecutive health checks successes required before considering an unhealthy target healthy"
  type            = number
  default         = 2
}
variable "health_check_unhealthy_threshold" {
  description     = "The number of consecutive health check failures required before considering a target unhealthy"
  type            = number
  default         = 2
}

#--------------------------Configure Auto Scaling group ---------------------------#

variable "autoscaling_group_name" {
  description     = "The name of the Auto Scaling Group"
  type            = string
  default         = "Dev_Frontend_ASG"
}

variable "min_size" {
  description     = "The minimum number of instances in the ASG"
  type            = number
  default         = 1
}

variable "max_size" {
  description     = "The maximum number of instances in the ASG"
  type            = number
  default         = 2
}

variable "desired_capacity" {
  description     = "The desired number of instances in the ASG"
  type            = number
  default         = 1
}

variable "subnet_ids" {
  description     = "The list of subnet IDs where the instances will be launched"
  type            = list(string)
  default         = [ "subnet-04c0c823118f48202" ]    #Frontend-Pvt-Subnet ID
}

variable "tag_key" {
  description     = "The key for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Name"
}

variable "tag_value" {
  description     = "The value for the tag to be applied to the ASG and instances"
  type            = string
  default         = "Dev_Frontend_ASG"
}

variable "propagate_at_launch" {
  description     = "Whether the tag should be propagated to instances launched by the ASG"
  type            = bool
  default         = true
}

#-----------------------xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -----------------------#
