require File.expand_path('../support/helpers', __FILE__)
require 'pathname'
require 'etc'

describe 'rtstps::default' do

  include Helpers::Rtstps

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
    directory(rtstps_install.to_path).must_exist.with(:owner, node['rtstps']['user'])
  end
  
  it 'sets up the environment for rtstps' do
    file("/etc/profile.d/rtstps_env.sh").must_exist.with(:mode, "0644")
  end
  
end
