mysql_user_password=$1
if [ -z "${mysql_user_password}" ];then
   echo "no input password given"
   exit 1
fi 
dnf module disable mysql -y 
cp mysql.repo /etc/yum.repos.d/
dnf install mysql-community-server -y
systemctl enable mysqld
systemctl restart mysqld  
mysql_secure_installation --set-root-pass ${mysql_user_password}
mysql -uroot -p${mysql_user_password}
