resource "aws_ecr_repository" "frontend" {
  name = "${var.environment}-frontend"
}

resource "aws_ecr_repository" "backend" {
  name = "${var.environment}-backend"
}
