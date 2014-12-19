class laravel::configs {
  
  Exec {
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin', '/bin/sh'],
  }

  exec { "chown -R apache:apache /var/www/html/${::laravel::project_name}/":
    unless => "/bin/sh -c '[ $(/usr/bin/stat -c %U%G /var/www/html/${::laravel::project_name}/app/storage) == apacheapache ]'",
  }

  exec { "chmod -R 777 /var/www/html/${::laravel::project_name}/app/storage/":
    unless => "/bin/sh -c '[ \$(/usr/bin/stat -c %a /var/www/html/${::laravel::project_name}/app/storage) == 777 ]'", 
  }

  file { "/etc/httpd/conf.d/${::laravel::project_name}.conf":
    ensure  => present,
    mode    => '0644',
    content => template('laravel/project.conf.erb'),
  }

  file { "/var/www/html/${::laravel::project_name}/public/index.php":
    ensure  => present,
    content => template('laravel/index.php.erb'),
  }
 
  host { "${::laravel::project_name}":
    ip           => "${::ipaddress}",
    host_aliases => split("${::laravel::server_alias}", ' '),
  }
}
