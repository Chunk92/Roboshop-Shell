nodejs(){
dnf module disable nodejs -y
dnf module enable nodejs:18 -y
dnf install nodejs -y
dnf install npm -y
useradd roboshop
cp ${component}.service /etc/systemd/system/
rm -rf /app
mkdir /app 
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 
cd /app 
unzip /tmp/${component}.zip
cd /app 
npm install 
systemctl daemon-reload
systemctl enable ${component} 
systemctl restart ${component}
}