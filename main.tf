resource "azurerm_public_ip" "component" {
  for_each = var.components
  name                = "${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "component" {
  for_each = var.components

  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${each.key}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = each.key == "frontend" ? azurerm_public_ip.frontend.id : null
  }
}

resource "azurerm_linux_virtual_machine" "component" {
  for_each = var.components

  name                  = "${each.key}-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids  = [azurerm_network_interface.component[each.key].id]
  size                  = each.value

  source_image_id = var.image_id

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

resource "azurerm_dns_a_record" "component" {
  for_each = var.components

  name                = "${each.key}-dev"
  zone_name           = "piple.site"
  resource_group_name = var.resource_group_name
  ttl                 = 30

  records = [
    azurerm_network_interface.component[each.key].private_ip_address
  ]
}