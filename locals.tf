locals {
  DOCDB_USER = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["DOCDB_USER"]
  DOCDB_PASS = jsondecode(data.aws_secretsmanager_secret_version.roboshop.secret_string)["DOCDB_PASS"]
}