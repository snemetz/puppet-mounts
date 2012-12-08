# = Class: mounts::params
#
# Default variables
#
class mounts::params {
  $options = 'rw,bg,vers=3,tcp,timeo=600,retrans=2,hard,intr,rsize=32768,wsize=32768'
  $fstype  = 'nfs'
  $ensure  = 'mounted'
}
