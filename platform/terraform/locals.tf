locals {
    lb_access_logs_path = "${var.app_name}/${var.loadbalancer_config.access_logs_prefix}/AWSLogs/${var.account_id}"
}