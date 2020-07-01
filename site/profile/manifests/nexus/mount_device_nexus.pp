profile profile::nexus::mount_device_nexus (
  $device    = undef,
  $path      = undef,
  $options   = 'noatime,nodiratime,rw,nouuid',

) {

  if empty($device) or empty($path) {
    notice("Skipping mounting device '${device}' to path '${path}' : device or path is empty")
  } else {
    filesystem { "Filesystem ${device}":
      ensure  => present,
      name    => $device,
      fs_type => 'xfs',
      options => '-f'
    } ->
    exec { "mkdir ${path}":
      command => "mkdir -p ${path}",
      creates => $path,
      path    => '/bin:/usr/bin'
    } ->
    exec { "Fix readahead ${device}":
      command => "/sbin/blockdev --setra 32 ${device}",
      unless  => "/sbin/blockdev --getra ${device} | grep -w 32"
    } ->
    mount { "Mounting ${path} to ${device}":
      ensure  => mounted,
      name    => $path,
      device  => $device,
      fstype  => 'xfs',
      options => $options,
      atboot  => true
    }
  }
}
