# Configure the Google Cloud provider
provider "google" {
  credentials = file("key.json")
  project     = "bangkit-demo-379000"
  region      = "asia-southeast2-a"
}

# Configure the remote state backend
terraform {
  backend "gcs" {
    bucket         = "test-terraform-1"
    prefix         = "terraform/state"
    credentials    = "key.json"
  }
}

variable "machine_memory" {
  description = "The memory size (in MB) of the virtual machine"
  type        = number
  default     = 2048
}

# Create a new virtual machine
resource "google_compute_instance" "my-vm" {
  name         = "test-my-vm-1"
  machine_type = "e2-small"
  zone         = "asia-southeast1-a"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  
  network_interface {
    network = "default"
    access_config {
    }
  }
}
