#User that will run RT-STPS
default['rtstps']['user'] = "processing"

#Relative to the RTSPS users home directory
default['rtstps']['path'] = "/opt"

#Name of the RT-STPS package.  Due to distribution restrictions, you must
#  download it and mirror the content locally
default['rtstps']['source'] = "http://example.com/RT-STPS_5.3.tar.gz"
default['rtstps']['cache_dir'] = Chef::Config[:file_cache_path]
