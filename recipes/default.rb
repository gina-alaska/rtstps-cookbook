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

remote_file "#{node['rtstps']['path']}/leapsec.dat" do
  source 'ftp://is.sci.gsfc.nasa.gov/ancillary/temporal/leapsec.2015091401.dat'
  not_if { node['rtstps']['update-leapsec'] == false }
  notifies :run, 'ruby_block[disable-update-leapsec]', :immediately
end

ruby_block 'disable-update-leapsec' do
  action :nothing
  block do
    node.default['rtstps']['update-leapsec'] = false
  end
end

