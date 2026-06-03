component=catalogue
source common.sh
func_nodejs
dnf install mongodb-org-shell -y
mongo --host mongodb.linuxchunk.online </app/schema/catalogue.js