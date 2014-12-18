# === Class: test
#
# Test
#
# === Parameters
#
# === Example
#
# include test
#
# === Authors
#
# Vasyl Mykhailyshyn (fullhaus1991@gmail.com)
#
class test (
) {

  file { '/tmp/test':
    ensure => file, 
    group  => 'root',
    owner  => 'root',
    mode   => '0750',
  }
}

