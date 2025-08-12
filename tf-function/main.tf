terraform {}

locals {
  value = "Hello, World!"
}

variable "str_list" {
  type = list(string)
  default = [ "server1", "server2", "server3" , "server1" ]
}

output "output" {
    #value = upper(local.value)
    #value = startswith(local.value, "hello")
    #value = split(" ",local.value)
    #value = max(1,2,3,4,5)
    #value = abs(-1)
    #value = length(var.str_list)
    #value = join(":", var.str_list)
    #value = contains(var.str_list, "Server2")# false as it is case sensitive
    value = toset(var.str_list) # converts list to set

}
