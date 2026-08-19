resource "azurerm_public_ip" "frontend" {

  name                = "frontend"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "frontend" {
  for_each = var.components
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {

    name                          = "${each.key}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend.id
  }
}

resource "azurerm_linux_virtual_machine" "frontend" {
  for_each = var.components
  name                  = "frontend-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.frontend.id]
  size                  = each.value

  source_image_id =  var.image_id
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true

}

resource "azurerm_dns_a_record" "frontend" {
  name                = "frontend-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.frontend.private_ip_address]
}

resource "azurerm_network_interface" "mysql" {
  for_each = var.components
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "mysql-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "mysql" {
  for_each = var.components
  name                  = "mysql-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.mysql.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "mysql" {
  name                = "mysql-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.mysql.private_ip_address]
}

resource "azurerm_network_interface" "catalogue" {
  name                = "catalogue-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "catalogue-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "catalogue" {
  for_each = var.components
  name                  = "catalogue-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.catalogue.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "catalogue" {
  name                = "catalogue-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.catalogue.private_ip_address]
}

resource "azurerm_network_interface" "mongodb" {
  name                = "mongodb-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "mongodb-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "mongodb" {
  for_each = var.components
  name                  = "mongodb-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.mongodb.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "mongodb" {
  name                = "mongodb-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.mongodb.private_ip_address]
}

resource "azurerm_network_interface" "user" {
  name                = "user-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "user-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "user" {
  for_each = var.components
  name                  = "user-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.user.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "user" {
  name                = "user-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.user.private_ip_address]
}

resource "azurerm_network_interface" "valkey" {
  name                = "valkey-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "valkey-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "valkey" {
  for_each = var.components
  name                  = "valkey-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.valkey.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "valkey" {
  name                = "valkey-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.valkey.private_ip_address]
}

resource "azurerm_network_interface" "cart" {
  name                = "cart-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "cart-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "cart" {
  for_each = var.components
  name                  = "cart-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.cart.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "cart" {
  name                = "cart-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.cart.private_ip_address]
}

resource "azurerm_network_interface" "shipping" {
  name                = "shipping-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "shipping-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "shipping" {
  for_each = var.components
  name                  = "shipping-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.shipping.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "shipping" {
  name                = "shipping-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.shipping.private_ip_address]
}

resource "azurerm_network_interface" "rabbitmq" {
  name                = "rabbitmq-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "rabbitmq-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "rabbitmq" {
  for_each = var.components
  name                  = "rabbitmq-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.rabbitmq.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "rabbitmq" {
  name                = "rabbitmq-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.rabbitmq.private_ip_address]
}

resource "azurerm_network_interface" "payment" {
  name                = "payment-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "payment-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "payment" {
  for_each = var.components
  name                  = "payment-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.payment.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "payment" {
  name                = "payment-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.payment.private_ip_address]
}

resource "azurerm_network_interface" "notification" {
  name                = "notification-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "notification-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "notification" {
  for_each = var.components
  name                  = "notification-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.notification.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "notification" {
  name                = "notification-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.notification.private_ip_address]
}

resource "azurerm_network_interface" "orders" {
  name                = "orders-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "orders-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "orders" {
  for_each = var.components
  name                  = "orders-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.orders.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "orders" {
  name                = "orders-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.orders.private_ip_address]
}

resource "azurerm_network_interface" "ratings" {
  name                = "ratings-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ratings-nic"
    subnet_id                     = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Network/virtualNetworks/Allow_all/subnets/default"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "ratings" {
  for_each = var.components
  name                  = "ratings-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.ratings.id]
  size                  = each.value

  source_image_id = "/subscriptions/5d6d5b42-ee4c-46d9-aed6-49fd22f441fe/resourceGroups/pomegranate/providers/Microsoft.Compute/galleries/Pomo/images/1.1.0/versions/1.1.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "bala@1234567"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true
}

resource "azurerm_dns_a_record" "ratings" {
  name                = "ratings-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.ratings.private_ip_address]
}