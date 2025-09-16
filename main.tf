resource "aws_docdb_subnet_group" "default" {
  name       = "${var.env}-${var.name}-roboshop-docdb"
  subnet_ids = var.subnets

  tags = {
    Name = "${var.env}-${var.name}-roboshop-docdb"
  }
}

resource "aws_docdb_cluster" "docdb" {
  depends_on             = [aws_docdb_subnet_group.default]
  cluster_identifier     = "${var.env}-${var.name}-roboshop-docdb"
  engine                 = var.engine
  master_username        = local.DOCDB_USER
  master_password        = local.DOCDB_PASS
  skip_final_snapshot    = var.skip_final_snapshot
  db_subnet_group_name   = "${var.env}-${var.name}-roboshop-docdb"
  vpc_security_group_ids = [aws_security_group.sg.id]
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  for_each           = var.nodes
  identifier         = "${var.env}-${var.name}-roboshop-docdb-${each.key}"
  cluster_identifier = aws_docdb_cluster.docdb.id
  instance_class     = each.value.instance_class
}