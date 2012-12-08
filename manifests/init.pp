# = Class: mounts
#
# Wrapper for mount type to provide data driven mount config,
# groups, and virtualization
#
# == Author
#  Steven Nemetz
#
class mounts {

  $mount_defs = hiera('mounts_defs')
  $mount_keys = keys($mount_defs)
  if is_array($mount_keys) {
    # Defaults
    $share_host = hiera('mounts_share_host', '')
    $options    = hiera('mounts_options', $mounts::params::options)
    $fstype     = hiera('mounts_fstype', $mounts::params::fstype)
    $ensure     = hiera('mounts_ensure', $mounts::params::ensure)
    # Create virtual mount definitions
    @mounts::virtual { $mount_keys:; }
  } else {
    notify { "MOUNTS not array of hash keys ${mount_keys} --- ${mount_defs}": }
  }
  # Realize the default mounts list
  #mounts::list{'default':}
}
