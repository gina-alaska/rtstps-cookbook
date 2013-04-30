#User that will run RT-STPS
default['rtstps']['user'] = "processing"

#Relative to the RTSPS users home directory
default['rtstps']['path'] = "rt-stps"

#Name of the RT-STPS package.  Due to distribution restrictinos, you must 
#  download it and place it in the 'download_cache' directory prior to 
#  using this cookbook.
default['rtstps']['source'] = "RT-STPS_5.3.tar.gz"
default['rtstps']['cache'] = "cache"