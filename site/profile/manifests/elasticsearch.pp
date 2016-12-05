#
# Sets up elasticsearch instance and waits for the service to start
#
class profile::elasticsearch (

  $plugins_hash   = undef,
  $security_group = 'not_available',
  $cluster_name   = undef,
  $heap_size      = undef,
  $config         = undef,
  $status         = running,

) {

  class { '::profile::elasticsearch::setup':
    plugins_hash   => $plugins_hash,
    security_group => $security_group,
    cluster_name   => $cluster_name,
    heap_size      => $heap_size,
    config         => $config,
    status         => $status,
  } ->
  class { '::profile::elasticsearch::wait':
    status => $status,
  }

  contain ::profile::elasticsearch::setup
  contain ::profile::elasticsearch::wait

  include ::profile::common::concat
  include ::profile::common::cloudwatchlogs

  profile::register_profile { 'elasticsearch': }

}
