variable "vpc-cidr" {
 default = "10.0.0.0/16"
 description = "vpc cidr block"
 type = string
  }


variable "public-subnet-1-cidr" {
 default = "10.0.0.0/24"
 description = "public subnet 1 cidr block"
 type = string
  }


variable "public-subnet-2-cidr" {
 default = "10.0.1.0/24"
 description = "public subnet 2 cidr block"
 type = string
  }

variable "private-subnet-1-cidr" {
 default = "10.0.2.0/24"
 description = "private subnet 1 cidr block"
 type = string
  }

variable "private-subnet-2-cidr" {
 default = "10.0.3.0/24"
 description = "private subnet 2 cidr block"
 type = string
  }

variable "private-subnet-3-cidr" {
 default = "10.0.4.0/24"
 description = "private subnet 3 cidr block"
 type = string
  }

variable "private-subnet-4-cidr" {
 default = "10.0.5.0/24"
 description = "private subnet 4 cidr block"
 type = string
  }


variable "aws_region" {
  description = "Region in which AWS was created"
  type        = string
  default     = "eu-west-1"
}

variable "ec2_ami_id" {
  description = "ami-0d729d2846a86a9e7"
  type        = string
  default     = "" # Amazon2 Linux AMI ID
}

variable "ec2_instance_count" {
  description = "EC2 Instance Count"
  type        = number
  default     = 2
}
