resource "azurerm_network_interface" "interface" {
  name                = "${var.application_type}-${var.resource_type}-interface"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

resource "azurerm_linux_virtual_machine" "virtualmachine" {
  name                = "VirtualMachine"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.interface.id
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDVFs4QYANRZrvRi6RGkcjd0ZzFgLLybIxwR0sCIs5YFygy9WJFflqLiHj5diX96aJ4YO9E/qwxq/KUt2EHR3Lp/CnOC6plwEVO0Ff3UzmQxRFm0LjtEqJUETZrZgmS44LsQPyFQhNX/4027usUvhNz5BpQbKx0NojhVqkFdEroHiVTwYsaN2tbZta9utkyalP1IGnYAXRyWAudWCMfHqQfVFaAKAYxVBFX6kzz6igzgp3iXlIMIzbOcBkELe/+7pdFfyK8NdnzgejTWfAk8JfAMgA28DraPZMNlLvZnTxEk8t72UYMD4Vphh+s0KcA802dHRd0c05YOZFBIIQBFrEJ geetika@cc-2219f63b-cf6977bfc-p52kz"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}
