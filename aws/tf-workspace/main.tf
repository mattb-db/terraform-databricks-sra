# =============================================================================
# Databricks Workspace Resources
# Rights assignment
# Clusters
# Policies
# Groups
# =============================================================================

# Cluster Version
data "databricks_spark_version" "latest_lts" {
  long_term_support = true
}

# Cluster Creation
resource "databricks_cluster" "standard_classic_compute_plane_cluster" {
  cluster_name            = "Standard Classic Compute Plane Cluster"
  data_security_mode      = "SINGLE_USER"
  spark_version           = data.databricks_spark_version.latest_lts.id
  node_type_id            = "m6idn.xlarge"
  autotermination_minutes = 10
  autoscale {
    min_workers = 1
    max_workers = 2
  }

  # Custom Tags
  custom_tags = {
    "SRA" = "Yes"
  }

  aws_attributes {
    availability           = "SPOT"
    zone_id                = "auto"
    first_on_demand        = 1
    spot_bid_price_percent = 100
  }
}