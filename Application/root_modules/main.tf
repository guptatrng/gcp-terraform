module "nginx_app" {
    source = "git::https://github.com/guptatrng/gcp-terraform.git//Application/child_modules?ref=main"
    project = var.project
    network = var.network
    subnetwork = var.subnetwork
    global_address_name = var.global_address_name
    global_forwarding_rule_name = var.global_forwarding_rule_name
    global_target_http_proxy_name = var.global_target_http_proxy_name
    url_map_name = var.url_map_name
    backend_service_name = var.backend_service_name
    health_check_name = var.health_check_name
    region_instance_group_manager_name = var.region_instance_group_manager_name
    instance_template_name = var.instance_template_name
    firewall_name = var.firewall_name
    instance_group_autoscaler_name = var.instance_group_autoscaler_name
}