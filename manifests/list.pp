# = Define: Mounts::list
#
# Realize a mount entry or list
#
define mounts::list {
  $list = params_lookup("mounts_list_${name}", 'global')
  #$list = params_lookup("list_${name}")
  if $list != '' {
    mounts::list { $list:; }
  } else {
    mounts::real { $name:; }
  }
} 
