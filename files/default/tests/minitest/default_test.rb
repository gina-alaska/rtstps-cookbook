require File.expand_path('../support/helpers', __FILE__)

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
    file(::File.join("/home",node['rtstps']['user'], 'rt-stps', 'VERSIONLOG')).must_exist
  end
end
