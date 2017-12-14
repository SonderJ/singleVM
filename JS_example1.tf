# Configure the IBM Cloud Provider
provider "ibm" {
  bluemix_api_key    = "${var.bluemix_api_key}"
  softlayer_username = "${var.softlayer_username}"
  softlayer_api_key  = "${var.softlayer_api_key}"
}

# Create an SSH key. You can find the SSH key surfaces in the SoftLayer console under Devices > Manage > SSH Keys
resource "ibm_compute_ssh_key" "test_key_1" {
  label      = "test_key_1"
  public_key = "${var.ssh_public_key}"
}

# Create a virtual server with the SSH key
resource "ibm_compute_vm_instance" "JS_server_1" {
  hostname          = "host1js"
  domain            = "example.com"
  ssh_key_ids       = ["${ibm_compute_ssh_key.test_key_1.id}"]
  os_reference_code = "CENTOS_6_64"
  datacenter        = "fra02"
  network_speed     = 10
  cores             = 1
  memory            = 1024
}

# Reference details of the IBM Bluemix Space
#data "ibm_space" "space" {
#  space = "${var.space}"
#  org   = "${var.org}"
#}

# Create an instance of an IBM service
#resource "ibm_service_instance" "service" {
#  name       = "${var.instance_name}"
#  space_guid = "${data.ibm_space.space.id}"
#  service    = "cleardb"
#  plan       = "cb5"
#  tags       = ["cluster-service", "cluster-bind"]
#}
