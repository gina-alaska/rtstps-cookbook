#
# Cookbook Name:: rtstps
# Recipe:: default
#
# Copyright (C) 2013 Scott Macfarlane
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"

rtstps '/opt/rt-stps' do
  source 'http://mirrors.gina.alaska.edu/NASA/RTSTPS/RT-STPS_5.8.tar.gz'
end

rtstps '/opt/rt-stps' do
  source 'http://mirrors.gina.alaska.edu/NASA/RTSTPS/RT-STPS_5.8_PATCH_1.tar.gz'
  action :patch
end

rtstps_leapsec "/opt/rt-stps/leapsec.dat" do
  source 'ftp://is.sci.gsfc.nasa.gov/ancillary/temporal/'
end
