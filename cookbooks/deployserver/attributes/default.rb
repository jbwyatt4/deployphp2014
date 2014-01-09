#--------IMPORTANT! CHANGE OR OVERRIDE-----------
default[:bluebook][:user_password] = "$1$.MZ8xPWB$/e/nAWc4C2zidbSVN9M/2/" #password
default[:bluebook][:postgres_password] = "$1$.MZ8xPWB$/e/nAWc4C2zidbSVN9M/2/" #password
default[:bluebook][:db_role_postgres_password] = "postgres_role_password"
default[:bluebook][:db_role_deploy_password] = "role_password"
# Vagrant public key-please, please, please, change this or set to empty string.
default[:bluebook][:authorized_keys] = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
"
#-----------------

# Package settings
default[:bluebook][:php_app_server] = "php-fpm" # or use "hiphop"

# Locations and other settings
default['bluebook']['nginx_server_name'] = "localhost"
default['bluebook']['app1'] = "php"
default['bluebook']['webroot'] = "/var/www"
default['bluebook']['app1_url'] = "#{default['bluebook']['webroot']}/#{default['bluebook']['app1']}"
default['bluebook']['blog_url'] = "http://wordpress.org/latest.tar.gz"
default['bluebook']['blog_archive'] = "latest.tar.gz"
default['bluebook']['blog_url2'] = "http://downloads.wordpress.org/plugin/postgresql-for-wordpress.1.3.0.zip" 
default['bluebook']['blog'] = "wordpress"
default['bluebook']['blog_loc'] = "#{default['bluebook']['webroot']}/#{default['bluebook']['blog']}"
# The current directory is used by Mina to link to the current version of the web app.
default['bluebook']['total_loc_app1'] = "#{default['bluebook']['webroot']}/#{default['bluebook']['app1']}/current"

default[:bluebook][:db_role_deploy_username] = "deploy"
default[:bluebook][:db_role_deploy_database] = "your_db"
