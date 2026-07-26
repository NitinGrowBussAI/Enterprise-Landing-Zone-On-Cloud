#!/bin/bash

yum update -y

yum install -y nginx

systemctl enable nginx

systemctl start nginx

TOKEN=$(curl -X PUT \
"http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds:21600")

INSTANCE_ID=$(curl \
-H "X-aws-ec2-metadata-token:$TOKEN" \
http://169.254.169.254/latest/meta-data/instance-id)

cat <<EOF >/usr/share/nginx/html/index.html

<html>

<h1>Enterprise Landing Zone</h1>

<p>Instance: $INSTANCE_ID</p>

</html>

EOF