property :install_path, String, name_property: true
property :source, String, required: true

default_action :install

action :install do
  filename = ::File.basename(new_resource.source)

  directory new_resource.install_path do
    action :create
    recursive true
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source new_resource.source
  end

  execute 'extract-rtspts' do
    command ["tar xvf #{Chef::Config[:file_cache_path]}/#{filename}",
             "-C #{new_resource.install_path}", "--strip-components=1"].join(" ")
    not_if { ::File.exists?("#{new_resource.install_path}/VERSIONLOG") }
  end
end

action :patch do
  filename = ::File.basename(new_resource.source)
  version = /^(RT-STPS_.*)\.(zip|tar\.gz)/.match(filename)[1]

  remote_file "#{Chef::Config[:file_cache_path]}/#{filename}" do
    source new_resource.source
  end

  log version

  execute 'patch-rtspts' do
    command ["tar xvf #{Chef::Config[:file_cache_path]}/#{filename}",
             "-C #{new_resource.install_path}", "--strip-components=1"].join(" ")
    not_if { ::File.exists?("#{new_resource.install_path}/VERSIONLOG_#{version}") }
  end
end

action :remove do
  directory new_resource.install_path do
    action :delete
    recursive true
  end
end
