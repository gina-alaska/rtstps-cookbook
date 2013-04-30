module Helpers
  module Rtstps_cookbook
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources
    
    def rtstps_install
      ::Pathname.new(::File.join("/home",node['rtstps']['user'], 'rt-stps'))
    end
  end
end
