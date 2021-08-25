#!/bin/sh

sudo apt-get install -y nginx
sudo service nginx start
HOSTNAME=$(hostname)

sudo cat > /var/www/html/index.html <<EOT
<html>
  <head><title>Blue Team Server</title></head>
  <body style=\"background-color:#1F778D\">
    Hello from Host $HOSTNAME
  </body>
</html>
EOT