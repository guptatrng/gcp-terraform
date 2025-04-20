variable "project" {
  description = "GCP project name"
}

variable "network" {
  description = "Network id for deployment"
}

variable "subnetwork" {
  description = "Subnetwork id for deployment"
}

variable "global_address_name" {
  description = "Name of global ip address"
}

variable "global_forwarding_rule_name" {
  description = "Name of global forwarding rule"
}

variable "global_target_http_proxy_name" {
  description = "Name of global target http proxy"  
}

variable "url_map_name" {
  description = "Name of url map"
}

variable "backend_service_name" {
  description = "Name of backend service"
}

variable "health_check_name" {
  description = "Name of load balancer health check"
}

variable "region_instance_group_manager_name" {
  description = "Name of regional instance group manager"
}

variable "instance_template_name" {
  description = "Name of instance template"
}

variable "firewall_name" {
  description = "Name of firewall for instance template"
}

variable "instance_group_autoscaler_name" {
  description = "Name of nginx instance group autoscaler"
}