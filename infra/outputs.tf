output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "service_name" {
  value = aws_ecs_service.app.name
}

output "task_definition" {
  value = aws_ecs_task_definition.app.family
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "alb_hostname" {
  description = "Full ALB hostname URL"
  value       = "http://${aws_lb.app.dns_name}"
}
