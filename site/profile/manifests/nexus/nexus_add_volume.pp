class profile::nexus:nexus_add_volume (

  $nexus_data_root  = '/data',
  $nexus_nodes      = '', # A string f.e. '[ "10.0.2.12", "10.0.2.23" ]'
  $storage_device   = undef,
){
   class { '::profile::common::mount_device':
     device  => $storage_device,
     path    => $nexus_data_root,
     options => 'noatime,nodiratime'
   } 
}
