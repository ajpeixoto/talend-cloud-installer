define profile::common::mount_device::fixup_ownership(
  $path,
  $owner,
  $group,
  $fixup_ownership_require = undef,
  $flag_file = "/var/tmp/${name}_ownership_fixup.done"
) {

  if $fixup_ownership_require {
    $_fixup_ownership_require = [Mount[$path], $fixup_ownership_require]
  } else {
    $_fixup_ownership_require = Mount[$path]
  }

  exec { "chown -R ${owner}:${group} ${path} && touch ${flag_file}":
    path    => '/bin:/usr/bin',
    creates => $flag_file,
    require => $_fixup_ownership_require
  }

}
