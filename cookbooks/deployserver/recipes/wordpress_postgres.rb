include_recipe "deployserver::wordpress"

if ::Dir.exist? "#{node['bluebook']['webroot']}/wordpress/wp-content/pg4wp"
  # Detected Wordpress is already installed, Exiting.
  # If Wp did not setup properly; delete the wordpress directory and try again.
  return
end

apt_package "unzip"

# download the postgres plugin
execute "cd #{node['bluebook']['blog_loc']}/wp-content; wget http://downloads.wordpress.org/plugin/postgresql-for-wordpress.1.3.0.zip" do
  user "www-data"
end

# uncompress
execute "cd #{node['bluebook']['blog_loc']}/wp-content; unzip postgresql-for-wordpress.1.3.0.zip" do
  user "www-data"
end

# copy pg4wp directory to wp-content
execute "cp -rf #{node['bluebook']['blog_loc']}/wp-content/postgresql-for-wordpress/pg4wp #{node['bluebook']['blog_loc']}/wp-content/pg4wp" do
  user "www-data"
end

# copy the db settings file
execute "cp #{node['bluebook']['blog_loc']}/wp-content/pg4wp/db.php #{node['bluebook']['blog_loc']}/wp-content/db.php" do
  user "www-data"
end

execute "chown -R www-data:www-data #{node['bluebook']['webroot']}" do
  user "root"
end
