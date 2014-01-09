# Just a index.php with the phpinfo

directory "#{node['bluebook']['webroot']}" do
  user "www-data"
end

template "#{node['bluebook']['webroot']}/index.php" do
  owner "www-data"
end
