#
# Cookbook:: dl-amq
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'wget'

#get amq file
cookbook_file '/tmp/install_amq.bash' do
  source 'install_amq.bash'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#install amq
execute 'execute install_amq.bash' do
 action :run
 command '/tmp/install_amq.bash'
end

#amq config
execute 'change activemq.xml' do
 action :run
 command 'curl -L https://raw.githubusercontent.com/champtc/Infrastructure/master/Docker/ctci/activemq/conf/activemq.xml > /opt/activemq/conf/activemq.xml'
end

#restart activemq
execute 'restart activemq' do
 action :run
 command 'systemctl restart activemq.service'
end
