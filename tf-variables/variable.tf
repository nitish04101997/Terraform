variable "aws_instance_type" {
  description = "What type of instance to use for the EC2 instance (should be t2.nano or t2.micro)"
  type        = string
  validation {
    condition = var.aws_instance_type=="t2.nano" || var.aws_instance_type=="t2.micro"
    error_message = "The instance type must be either t2.nano or t2.micro."
  }
}




/*
variable "root_size_variable" {
  description = "What is the size of the root block device in GB."
  type        = number
  default     = 8
}

variable "root_block_type" {
    description = "What type of root block device to use for the EC2 instance."
    type        = string
    default     = "gp2"
    validation {
        condition     = var.root_block_type == "gp2" || var.root_block_type == "io1" || var.root_block_type == "io2"
        error_message = "The root block type must be either gp2, io1, or io2."
    }
}
*/



variable "ec2_config" {
    type = object({
        v_size = number
        v_type = string
    })
    default = {
        v_size = 8
        v_type = "gp2"
    }
}


variable "additional_tags" {
    type = map(string) #expecting key-value pairs for additional tags
    default = {}
}


