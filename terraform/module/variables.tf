# Variables for ECS child module

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_cidr_az2" {
  default = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "The availability zone for the public subnet"
  type        = string
}

variable "availability_zone_2" {
  default = "us-east-1b"
}

variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "ecs_task_family" {
  description = "The family name for the ECS task definition"
  type        = string
}

variable "ecs_cpu" {
  description = "The amount of CPU for the ECS task"
  type        = string
}

variable "ecs_memory" {
  description = "The amount of memory for the ECS task"
  type        = string
}

variable "container_name" {
  description = "The name of the container in the ECS task"
  type        = string
}

variable "docker_image" {
  description = "The Docker image for the container"
  type        = string
}

variable "container_port" {
  description = "The container port to expose"
  type        = number
}

variable "host_port" {
  description = "The host port to expose"
  type        = number
}

variable "ecs_desired_count" {
  description = "The desired number of ECS tasks"
  type        = number
}

variable "ecs_service_name" {
  description = "The name of the ECS service"
  type        = string
}

variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}

variable "alb_port" {
  description = "The port for the ALB"
  type        = number
}

variable "alb_listener_port" {
  description = "The listener port for the ALB"
  type        = number
}
