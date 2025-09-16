resource "null_resource" "load-schema" {
  depends_on = [aws_docdb_cluster.docdb, aws_docdb_cluster_instance.cluster_instances]

  provisioner "local-exec" {
    command = <<EOF
sleep 60
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip"
cd /tmp
unzip -o mongodb.zip
cd mongodb-main
curl -L -O https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem
mongosh dev-db1-roboshop-docdb.cluster-c0xiwoigwrqk.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < catalogue.js
mongosh dev-db1-roboshop-docdb.cluster-c0xiwoigwrqk.us-east-1.docdb.amazonaws.com:27017 --tls --tlsCAFile global-bundle.pem --retryWrites=false --username ${local.DOCDB_USER} --password ${local.DOCDB_PASS} < users.js
EOF
  }

}