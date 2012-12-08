# = Define: mounts::virtual
#
define mounts::virtual {
  if is_string($name) {
    # This should be a hash key
    if is_hash($mounts::mount_defs[$name]) {
      # Build resource variables
      if $mounts::mount_defs[$name]['share_path'] != '' {
        $share_path = $mounts::mount_defs[$name]['share_path']
      } else {
        fail('ERROR: share path is required')
      }
      if $mounts::mount_defs[$name]['share_host'] != '' {
        $share_host = $mounts::mount_defs[$name]['share_host']
      } elsif $mounts::share_host != '' {
        $share_host = $mounts::share_host
      } else {
        fail('ERROR: share host is required')
      }
      $device = "${share_host}:${share_path}"
      if $mounts::mount_defs[$name]['mount_path'] != '' {
        $mount_point = $mounts::mount_defs[$name]['mount_path']
      } else {
        fail('ERROR: mount path is required')
      }
      if $mounts::mount_defs[$name]['fstype'] != '' {
        $fstype = $mounts::mount_defs[$name]['fstype']
      } else {
        $fstype = $mounts::fstype
      }
      if $mounts::mount_defs[$name]['options'] != '' {
        $options = $mounts::mount_defs[$name]['options']
      } else {
        $options = $mounts::options
      }
      # Ensure mount point if not mounted
      exec { 'mk_mnt_pt':
        path    => ['/bin'],
        unless  => "/bin/mountpoint -q ${mount_point}",
        command => "mkdir -p ${mount_point}; chmod 0000 ${mount_point}",
      }

      # Define mount
      mount { $name:
        ensure   => present, # change later - allow to be passed
        device   => $device,
        name     => $mount_point,
        fstype   => $fstype,
        options  => $options,
        remounts => true,
        requires => Exec['mk_mnt_pt'],
      }
    } else {
      notify{ "${name} is not a key to a hash":}
    }
  } else {
    notify{"${name} is not a string":}
  }
}
