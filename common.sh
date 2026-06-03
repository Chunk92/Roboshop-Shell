func_systemd(){
systemctl daemon-reload
systemctl enable ${component} 
systemctl restart ${component}  
}

func_apppreq(){
useradd roboshop
rm -rf /app
mkdir /app 
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
cd /app 
unzip /tmp/${component}.zip
cd /app 
}


func_nodejs(){
cp ${component}.service /etc/systemd/system/
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
dnf install npm -y
func_apppreq
npm install 
func_systemd
}

func_java(){
dnf install maven -y
cp ${component}.service /etc/systemd/system/
func_apppreq
mvn clean package 
mv target/${component}-1.0.jar ${component}.jar 
func_systemd
dnf install mysql -y 
mysql -h mysql.linuxchunk.online -uroot -pRoboShop@1 < /app/schema/${component}.sql 
systemctl restart ${component}
}

func_golang(){
dnf install golang -y
cp dispatch.service /etc/systemd/system/
func_apppreq
go mod init dispatch
go get 
go build
func_systemd  
}