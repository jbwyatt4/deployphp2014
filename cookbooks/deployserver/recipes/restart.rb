# For apt-get to generate update timestamps.
execute "Restart after first time" do
  command "touch /etc/chefflag-reboot; reboot"
  user "root"
  not_if do
    ::File.exists?('/etc/chefflag-reboot')
  end
end
