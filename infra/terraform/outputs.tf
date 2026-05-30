output "lambda_function_name" {
  description = "Nome da funcao Lambda que executa a rotina de alerta."
  value       = aws_lambda_function.email_alert.function_name
}

output "eventbridge_rule_name" {
  description = "Nome da regra do EventBridge que agenda a rotina."
  value       = aws_cloudwatch_event_rule.schedule.name
}

output "sender_identity_arn" {
  description = "ARN da identidade SES do endereco de e-mail remetente."
  value       = aws_ses_email_identity.sender.arn
}

output "recipient_identity_arn" {
  description = "ARN da identidade SES do endereco de e-mail destinatario."
  value       = aws_ses_email_identity.recipient.arn
}
