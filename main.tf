resource "aws_docdb_subnet_group" "default" {
  name       = "${var.env}-${var.name}-roboshop-docdb"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${var.name}-roboshop-docdb"
  }
}

resource "aws_docdb_cluster" "docdb" {
  depends_on = [aws_docdb_subnet_group.default]
  cluster_identifier     = "${var.env}-${var.name}-roboshop-docdb"
  engine                 = var.engine
  master_username        = "admin1"
  master_password        = "mustbeeightchars"
  skip_final_snapshot    = true
  db_subnet_group_name   = "${var.env}-${var.name}-roboshop-docdb"
}
