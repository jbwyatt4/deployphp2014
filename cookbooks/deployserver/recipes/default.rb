#
# Cookbook Name:: deployserver
# Recipe:: default
#
# Copyright 2013, John B. Wyatt IV
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

###########################
#
# Update & upgrade the node
#
###########################

template "/etc/apt/apt.conf.d/15update-stamp" do
  source "15update-stamp"
  mode 0440
  owner "root"
  group "root"
end

execute "update apt" do # this becomes just a name with cmd
  command 'apt-get update'
  user "root"
  ignore_failure true
  not_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    File.mtime('/var/lib/apt/periodic/update-success-stamp') > Time.now - 86400
  end
end

execute 'sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade' do
  user "root"
end

execute 'sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade' do
  user "root"
end

execute "apt-get autoremove -y" do
  user "root"
end

############################
#
# Install fail2ban
# You can use a template to override the defaults
#
############################


package "fail2ban"

execute "fail2ban" do
  command 'cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local'
  not_if do
    ::File.exists?("/etc/fail2ban/jail.local")
  end
  user "root"
end

#############################
#
# Setup the 'user' user.
# Please see the section in Deploy Rails BlueBook
# on how to set the password.
#
#############################

user "user" do
  supports :manage_home => true
  comment "Our user!"
  uid 1235
  gid "users"
  home "/home/user"
  shell "/bin/bash"
  password node.default['bluebook']['user_password'] #password - must be hashed
end

directory "/home/user/.ssh" do
  owner "user"
end

template "/home/user/.ssh/authorized_keys" do
  source "authorized_keys"
  mode 0400
  owner "user"
end

# Adds the user to sudoers file
# Not recommended for security
execute "Add user to sudoers file" do
  command "echo 'user     ALL=(ALL:ALL) ALL' >> /etc/sudoers; touch /etc/chefflag-sudo;"
  user "root"
  not_if do
    ::File.exists?('/etc/chefflag-sudo')
  end
end
