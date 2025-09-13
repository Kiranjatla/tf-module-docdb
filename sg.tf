resource "aws_security_group" "sg" {
  name        = "${var.env}-${var.name}-docdb.sg"
  description = "${var.env}-${var.name}-docdb.sg"
  vpc_id      = var.vpc_id

  ingress {
    description = "MONGODB"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr, var.BASTION_NODE]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.env}-${var.name}-docdb.sg"
  }
}