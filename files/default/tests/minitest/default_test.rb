require File.expand_path('../support/helpers', __FILE__)
require 'pathname'
require 'etc'

describe 'rtstps-cookbook::default' do

  include Helpers::Rtstps_cookbook

  # Example spec tests can be found at http://git.io/Fahwsw
  # it 'runs no tests by default' do
  # end
  it 'will create the rtstps user' do
    user("#{node['rtstps']['user']}").must_exist
  end

  it 'will download rt-stps' do
    file(::File.join(node['rtstps']['cache'], node['rtstps']['source'])).must_exist
  end
  
  it 'will install rt-stps' do
    file(rtstps_install.join('VERSIONLOG').to_path).must_exist
  end
  
  it 'will give ownership of rt-stps to the correct user' do
    file(rtstps_install.to_path).must_exist.with(:owner, node['rtstps']['user']).with(:group, node['rtstps']['user'])
  end
  
end
