variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable secret_key_path {
  description = "Path to the secret key used for connection"
}

variable zone {
  description = "Zone for instance"
  default     = "europe-west1-d"
}

variable number_of_instances {
  description = "number of instances to create"
  default     = "1"
}
