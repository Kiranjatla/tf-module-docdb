resource "aws_docdb_subnet_group" "default" {
  for_each = var.docdb
  name       = "${var.env}-${each.key}-roboshop-docdb"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${each.key}-roboshop-docdb"
  }
}

resource "aws_docdb_cluster" "docdb" {
  depends_on = [aws_docdb_subnet_group.default]
  for_each = var.docdb
  cluster_identifier     = "${var.env}-roboshop-docdb"
  engine                 = each.value.engine
  master_username        = "admin"
  master_password        = "admin123"
  skip_final_snapshot    = true
  db_subnet_group_name = "${var.env}-${each.key}-roboshop-docdb"
}
