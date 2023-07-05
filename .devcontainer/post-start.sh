sudo bash -c "echo R_LIBS_USER=/workspaces/melody-angel/.R/library > /home/rstudio/.Renviron"
# ln -s /workspace/melody-angel /home/rstudio/melody-angel
# https://stackoverflow.com/questions/47541007/how-to-i-bypass-the-login-page-on-rstudio
sudo usermod -a -G sudo rstudio
sudo bash -c "echo 'server-user=rstudio' >> /etc/rstudio/rserver.conf"
sudo bash -c "echo 'auth-none=1' >> /etc/rstudio/rserver.conf"
# Restart the rserver with sudo otherwise it won't run for the rstudio user (dunno why)
sudo rserver
sudo pkill rserver
alias python='python3'
