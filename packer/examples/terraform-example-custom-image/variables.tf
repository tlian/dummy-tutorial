# Ensure to set the following Environment variables (i.e. export them via terminal)
# export TF_VAR_subscription_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# export TF_VAR_tenant_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# export TF_VAR_client_id="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# export TF_VAR_client_secret="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"


variable subscription_id {
    type      = string
    ephemeral = true
    sensitive = true
}

variable tenant_id {
    type      = string
    ephemeral = true
    sensitive = true
}

variable client_id {
    type      = string
    ephemeral = true
    sensitive = true
}

variable client_secret {
    type      = string
    ephemeral = true
    sensitive = true
}