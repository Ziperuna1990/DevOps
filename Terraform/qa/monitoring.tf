resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm will be triggered if CPU utilization exceeds 80% for EC2."
  dimensions = {
    InstanceId = aws_instance.backend_api_cloud.id
  }

  actions_enabled = true
  alarm_actions   = [aws_sns_topic.alerts.arn]
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_alarm" {
  alarm_name          = "rds-cpu-usage-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 85
  alarm_description   = "This alarm triggers if RDS CPU utilization exceeds 85%."
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.postgres.id
  }

  actions_enabled = true
  alarm_actions   = [aws_sns_topic.alerts.arn]
}

resource "aws_cloudwatch_metric_alarm" "redis_cpu_alarm" {
  alarm_name          = "redis-cpu-usage-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  alarm_description   = "This alarm triggers if Redis CPU usage exceeds 90%."
  dimensions = {
    CacheClusterId = aws_elasticache_cluster.redis.id
  }

  actions_enabled = true
  alarm_actions   = [aws_sns_topic.alerts.arn]
}

resource "aws_sns_topic" "alerts" {
  name = "alerts-topic"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = "andrii.revkach@gmail.com" # Ваш email
}