variable "ec2_config" {
    type = list(object({
      ami = string
      instance_type = string
    })) 

/*
    default = [ {
      {ami = "ami-020cba7c55df1f615" 
      instance_type = "t2.nano"
      }, {ami = "ami-020cba7c55df1f615" 
      instance_type = "t2.nano"}
    } ]
*/
}