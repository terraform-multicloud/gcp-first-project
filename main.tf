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