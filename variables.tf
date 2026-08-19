variable "location" {
  default = "Denmark East"
}

variable "resource_group_name" {
  default = "pomegranate"
}

variable "subnet_id" {
  default = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"

}

variable "image_id" {
  default = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"
}

variable "components" {
  default = {
    frontend     = "Standard_B1s"
    mysql        = "Standard_B1s"
    valkey       = "Standard_B1s"
    mongodb      = "Standard_B1s"
    rabbitmq     = "Standard_B1s"
    catalogue    = "Standard_B1s"
    user         = "Standard_B1s"
    cart         = "Standard_B1s"
    shipping     = "Standard_B1s"
    order        = "Standard_B1s"
    notification = "Standard_B1s"
    ratings      = "Standard_B1s"
    payment      = "Standard_B1s"
  }
}