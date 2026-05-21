cp mongo.repo /etc/yum.repos.d/
dnf install mongodb-org -y 
systemctl enable mongod 
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
systemctl restart mongod