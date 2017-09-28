user=app
password=`openssl rand -base64 32`
echo "$user:$password:::::" > users.txt

#Add app user
newusers users.txt
usermod -a -G sudo $user
cp -R .ssh /home/$user
chown +R $user:$user /home/$user/.ssh

#Git
sudo apt-get -y install git ufw

# Disable password authentication
sudo sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g' /etc/ssh/sshd_config
sudo sed -i 's|UsePAM yes|UsePAM no|g' /etc/ssh/sshd_config
sudo service ssh restart -y


#Setup firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow 22
sudo ufw allow 443
sudo ufw allow 80
sudo ufw enable