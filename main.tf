resource "google_storage_bucket" "gcs1" {
    name     = "himanshu-unique-bucket-name-12345"
    location = var.region
  
}