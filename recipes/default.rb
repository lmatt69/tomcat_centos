#
# Cookbook:: tomcat_centos
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'java-1.7.0-openjdk-devel'

group 'tomcat'

user 'tomcat' do
  comment 'Tomcat user'
  shell '/bin/nologin'
  home '/opt/tomcat'
  group 'tomcat'
  manage_home false
end

#wget http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz
remote_file 'apache-tomcat-8.5.15.tar.gz' do
  source 'http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.15/bin/apache-tomcat-8.5.15.tar.gz'
end

directory '/opt/tomcat' do
end

execute 'sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'

directory '/opt/tomcat/conf' do
  mode '070'
end

execute 'chgrp -R tomcat /opt/tomcat'
execute 'chmod -R g+r /opt/tomcat/conf'
execute 'chmod g+r /opt/tomcat/conf/*'

execute 'chown -R tomcat /opt/tomcat /opt/tomcat/webapps /opt/tomcat/work /opt/tomcat/temp /opt/tomcat/logs'

template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
end

execute 'systemctl daemon-reload'

service 'tomcat' do
  action [:start, :enable]
end
