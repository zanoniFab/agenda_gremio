variable "aws_region" {
  description = "Regiao da AWS onde a infraestrutura sera provisionada."
  type        = string
  default     = "sa-east-1"
}

variable "environment" {
  description = "Nome do ambiente de implantacao."
  type        = string
  default     = "dev"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.environment))
    error_message = "Use apenas letras minusculas, numeros e hifens."
  }
}

variable "project_name" {
  description = "Nome do projeto usado como prefixo dos recursos AWS."
  type        = string
  default     = "agenda-gremio"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Use apenas letras minusculas, numeros e hifens."
  }
}

variable "sender_email" {
  description = "Endereco de e-mail remetente verificado no SES."
  type        = string
}

variable "recipient_email" {
  description = "Endereco de e-mail destinatario verificado no SES."
  type        = string
}

variable "schedule_expression" {
  description = "Expressao de agendamento do EventBridge usada para acionar a rotina de alerta."
  type        = string
  default     = "rate(1 day)"
}
