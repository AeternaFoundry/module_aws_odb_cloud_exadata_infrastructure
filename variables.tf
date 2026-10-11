variable "odb_cloud_exadata_infrastructures" {
  description = <<EOT
Map of odb_cloud_exadata_infrastructures, attributes below
Required:
    - availability_zone_id
    - display_name
    - shape
Optional:
    - availability_zone
    - compute_count
    - database_server_type
    - region
    - storage_count
    - storage_server_type
    - tags
    - customer_contacts_to_send_to_oci (block):
        - email (optional)
    - maintenance_window (block):
        - custom_action_timeout_in_mins (required)
        - days_of_week (optional, block):
            - name (optional)
        - hours_of_day (optional)
        - is_custom_action_timeout_enabled (required)
        - lead_time_in_weeks (optional)
        - months (optional, block):
            - name (optional)
        - patching_mode (required)
        - preference (required)
        - weeks_of_month (optional)
EOT

  type = map(object({
    availability_zone_id = string
    display_name         = string
    shape                = string
    availability_zone    = optional(string)
    compute_count        = optional(number)
    database_server_type = optional(string)
    region               = optional(string)
    storage_count        = optional(number)
    storage_server_type  = optional(string)
    tags                 = optional(map(string))
    customer_contacts_to_send_to_oci = optional(list(object({
      email = optional(string)
    })))
    maintenance_window = optional(list(object({
      custom_action_timeout_in_mins = number
      days_of_week = optional(list(object({
        name = optional(string)
      })))
      hours_of_day                     = optional(set(number))
      is_custom_action_timeout_enabled = bool
      lead_time_in_weeks               = optional(number)
      months = optional(list(object({
        name = optional(string)
      })))
      patching_mode  = string
      preference     = string
      weeks_of_month = optional(set(number))
    })))
  }))
}

