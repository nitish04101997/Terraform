terraform {}

#NumberList
variable "num_list" {
  type    = list(number)
  default = [0, 1, 2, 3, 4]
}

#object List of person
variable "person_list" {
  type = list(object ({
    fname = string
    lname = string
    age  = number
  }))
  default = [ {
    fname = "Nitish",
    lname = "Verma",
    age   = 27
  },
  {
    fname = "John",
    lname = "Doe",
    age   = 30
    }]
}       

variable "map_list" {
    type = map(number)
    default = {
      "one" = 1
      "two" = 2
      "three" = 3
    }
}

#calculations
locals {
  mul = 2 * 2
  add = 2 + 2  
  eq = 2 != 2

  double = [for num in var.num_list: num * 2]
  odd = [for num in var.num_list: num if num%2 != 0]

  #person list
  person = [for p in var.person_list: p.fname]

  #working with map
  map_list = [for key, value in var.map_list: value*5]

  #double map
  double_map = { for key , value in var.map_list: key => value*2}
}

output "num_list" {
  value = local.double_map
}

output "output" {
  value = var.map_list
}


