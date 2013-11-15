#
# Cookbook Name:: rtstps-cookbook
# Recipe:: default
#
# Copyright (C) 2013 Scott Macfarlane
# 
# All rights reserved - Do Not Redistribute
#

#Install Java - Default is openjdk
include_recipe "java"

if node['recipes'].include? "dbvm-cookbook::default" 
  node.set['rtstps']['path'] = node['dbvm']['HOME'] + "/apps"
  node.set['rtstps']['user'] = node['dbvm']['user']
end

#Ensure the rtstps user exists
user node['rtstps']['user']

directory node['rtstps']['path'] do
  user node['rtstps']['user']
  group node['rtstps']['user']
  recursive true
end

execute 'extract rtspts' do
  command ["tar xvf #{node['rtstps']['cache']}/#{node['rtstps']['source']}",
           "-C #{node['rtstps']['path']}"].join(" ")
  user node['rtstps']['user']
  group node['rtstps']['user'] 
  not_if { ::File.exists?("#{node['rtstps']['path']}/rt-stps/VERSIONLOG") }
end

template "/etc/profile.d/rtstps-env.sh" do
  mode 0644
end