variable "client_id" {
  default = env("AZURE_CLIENT_ID")
}

variable "client_secret" {
  default = env("AZURE_CLIENT_SECRET")
}

variable "subscription_id" {
  default = env("AZURE_SUBSCRIPTION_ID")
}

variable "tenant_id" {
  default = env("AZURE_TENANT_ID")
}

variable "location" {
  default = "East US 2"
}
