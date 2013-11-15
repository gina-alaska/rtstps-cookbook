module Helpers
  module Rtstps
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    
    def rtstps_install
      ::Pathname.new("#{node['rtstps']['path']}/rt-stps")
    end
  end
end
