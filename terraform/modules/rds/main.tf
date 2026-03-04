resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "this" {
  identifier             = "${var.environment}-db"
  engine                 = "postgres"
  instance_class         = var.instance_class
  allocated_storage      = 20
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  skip_final_snapshot    = true
}
