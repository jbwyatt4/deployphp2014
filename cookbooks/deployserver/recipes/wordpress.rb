if ::Dir.exist? "#{node['bluebook']['blog_loc']}"
  # Detected Wordpress is already installed, Exiting.
  # If Wp did not setup properly; delete the wordpress directory and try again.
  return
end

directory "#{node['bluebook']['webroot']}" do
  user "www-data"
end

# download wordpress
execute "cd #{node['bluebook']['webroot']}; wget #{node['bluebook']['blog_url']}" do
  user "www-data"
end

# uncompress
execute "cd #{node['bluebook']['webroot']}; tar -zxvf #{node['bluebook']['blog_archive']}" do
  user "www-data"
end

# remove the installation package
execute "cd #{node['bluebook']['webroot']}; rm #{node['bluebook']['blog_archive']}" do
  user "www-data"
end

execute "chown -R www-data:www-data #{node['bluebook']['webroot']}" do
  user "root"
end
