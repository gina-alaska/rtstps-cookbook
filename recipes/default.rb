#
# Cookbook Name:: rtstps-cookbook
# Recipe:: default
#
# Copyright (C) 2013 Scott Macfarlane
# 
# All rights reserved - Do Not Redistribute
#

#Ensure the rtstps user exists
user node['rtstps']['user']

execute 'extract rtspts' do
  command "tar xvf #{node['rtstps']['cache']}/#{node['rtstps']['source']} -C /home/#{node['rtstps']['user']}"
  not_if { ::File.exists?("#{node['rtstps']['path']}/VERSIONLOG") }
end