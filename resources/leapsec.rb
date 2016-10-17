property :source, String, required: true
property :path, String, name_property: true
property :content, String

load_current_value do
  if ::File.exist?(path)
    content IO.read(path)
  end
end

action :create do
  file path do
    action :create_if_missing
    content get_latest(source)
  end
end

action :update do
  file path do
    content
  end
end

action :delete do
  file path do
    action :delete
  end
end

def get_latest(host)
  require 'uri'
  require 'net/ftp'

  uri = URI.parse(host)

  ftp = Net::FTP.new(uri.host)
  ftp.login
  ftp.chdir(uri.path)
  files = ftp.list('leapsec*').map{|f| f.split.last }

  leapsec = ""
  ftp.get files.last do |line|
    leapsec << line
  end

  leapsec
end