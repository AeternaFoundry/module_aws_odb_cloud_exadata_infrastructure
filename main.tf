resource "aws_odb_cloud_exadata_infrastructure" "odb_cloud_exadata_infrastructures" {
  for_each = var.odb_cloud_exadata_infrastructures

  availability_zone_id = each.value.availability_zone_id
  display_name         = each.value.display_name
  shape                = each.value.shape
  availability_zone    = each.value.availability_zone
  compute_count        = each.value.compute_count
  database_server_type = each.value.database_server_type
  region               = each.value.region
  storage_count        = each.value.storage_count
  storage_server_type  = each.value.storage_server_type
  tags                 = each.value.tags

  dynamic "customer_contacts_to_send_to_oci" {
    for_each = each.value.customer_contacts_to_send_to_oci != null ? each.value.customer_contacts_to_send_to_oci : []
    content {
      email = customer_contacts_to_send_to_oci.value.email
    }
  }

  dynamic "maintenance_window" {
    for_each = each.value.maintenance_window != null ? each.value.maintenance_window : []
    content {
      custom_action_timeout_in_mins = maintenance_window.value.custom_action_timeout_in_mins
      dynamic "days_of_week" {
        for_each = maintenance_window.value.days_of_week != null ? maintenance_window.value.days_of_week : []
        content {
          name = days_of_week.value.name
        }
      }
      hours_of_day                     = maintenance_window.value.hours_of_day
      is_custom_action_timeout_enabled = maintenance_window.value.is_custom_action_timeout_enabled
      lead_time_in_weeks               = maintenance_window.value.lead_time_in_weeks
      dynamic "months" {
        for_each = maintenance_window.value.months != null ? maintenance_window.value.months : []
        content {
          name = months.value.name
        }
      }
      patching_mode  = maintenance_window.value.patching_mode
      preference     = maintenance_window.value.preference
      weeks_of_month = maintenance_window.value.weeks_of_month
    }
  }
}

