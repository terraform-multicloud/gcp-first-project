# resource "google_storage_bucket" "gcs1" {
#     name     = "himanshu-unique-bucket-name-12345"
#     location = var.region

# }

resource "google_compute_instance" "vm1" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

}

resource "google_compute_disk" "default" {
  name  = "test-disk"
  type  = "pd-ssd"
  zone  = google_compute_instance.vm1.zone
  size = 50
}

resource "google_compute_attached_disk" "attachdisk" {
  instance = google_compute_instance.vm1.name
  disk     = google_compute_disk.default.name
  zone = google_compute_instance.vm1.zone
  
}



resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  auto_create_subnetworks = false
}


data "google_compute_regions" "all-regions" {

}

resource "google_compute_network" "dummynetwork" {
  name = "dummynetwork"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetworks" {
  count = length(data.google_compute_regions.all-regions.names)
  name          = "dummysubnetwork-${data.google_compute_regions.all-regions.names[count.index]}"
  region = data.google_compute_regions.all-regions.names[count.index]
  network       = google_compute_network.dummynetwork.id
  ip_cidr_range = "10.0.${count.index+1}.0/24"
  
}

