#
# Cookbook Name:: rtstps
# Recipe:: default
#
# Copyright (C) 2013 Scott Macfarlane
#
# All rights reserved - Do Not Redistribute
#

#Install Java - Default is openjdk
include_recipe "java"

#Ensure the rtstps user exists
user node['rtstps']['user']

directory "#{node['rtstps']['path']}/rt-stps" do
  user node['rtstps']['user']
  group node['rtstps']['user']
  recursive true
end

rtspts_filename = ::File.basename(node['rtstps']['source'])

remote_file "#{node['rtstps']['cache_dir']}/#{rtspts_filename}" do
  source node['rtstps']['source']
end

execute 'extract-rtspts' do
  command ["tar xvf #{node['rtstps']['cache_dir']}/#{rtspts_filename}",
           "-C #{node['rtstps']['path']}"].join(" ")
  user node['rtstps']['user']
  group node['rtstps']['user']
  not_if { ::File.exists?("#{node['rtstps']['path']}/rt-stps/VERSIONLOG") }
end

template "/etc/profile.d/rtstps_env.sh" do
  mode 0644
end
