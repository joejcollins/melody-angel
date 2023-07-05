sudo bash -c "echo R_LIBS_USER=/workspaces/melody-angel/.R/library > /home/codespace/.Renviron"
ln -s /workspace/melody-angel /home/codespace/melody-angel
# https://stackoverflow.com/questions/47541007/how-to-i-bypass-the-login-page-on-rstudio
sudo usermod -a -G sudo codespace
sudo bash -c "echo 'server-user=codespace' >> /etc/rstudio/rserver.conf"
sudo bash -c "echo 'auth-none=1' >> /etc/rstudio/rserver.conf"
# Restart the rserver with sudo otherwise it won't run for the codespace user (dunno why)
sudo rserver
sudo pkill rserver
alias python='python3'
