apt_package "build-essential"
apt_package "curl"
apt_package "nginx-full"
apt_package "php5-mysql"
apt_package "php5-fpm"
apt_package "php-apc"

# Set the nginx template
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  mode "311" # check this in the future -rw-r--r--
  owner "www-data"
end

# Start nginx
execute "sudo service nginx start; true" do
  "root"
end

# (Re)start nginx
execute "sudo service nginx restart; true" do
  "root"
end

# Start the PHP application server
# Note that php-fpm uses port 9000, just like xdebug
execute "sudo service php5-fpm start; true" do
  "root"
end
