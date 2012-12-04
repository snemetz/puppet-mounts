# = Define: Mounts::real
#
# Realize a mount entry
#
define mounts::real {
  realize ( Mounts::Virtual[ $name ] )
}
