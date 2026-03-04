resource "aws_ecr_repository" "backend" {
  name = "seto-${var.environment}-backend"
}

resource "aws_ecr_repository" "frontend" {
  name = "seto-${var.environment}-frontend"
}
