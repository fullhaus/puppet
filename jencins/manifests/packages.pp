class laravel::packages {

  Exec{
    path => ['/bin', '/sbin', '/usr/bin', '/usr/sbin', '/usr/local/bin', '/usr/local/sbin'],
  }

  Package {
    allow_virtual => true,
  }

  exec { 'rpm -i https://mirror.webtatic.com/yum/el6/latest.rpm':
    unless => 'rpm -q webtatic-release',
  }

  package { ['php55w', 'php55w-opcache', 'php55w-pdo', 'php55w-mcrypt']:
    ensure  => installed,
    require => Exec['rpm -i https://mirror.webtatic.com/yum/el6/latest.rpm'],
  }

  exec { 'Install composer.phar':
    command => 'curl -sS https://getcomposer.org/installer | php',
    cwd     => '/var/www/html',
    creates => '/var/www/html/composer.phar',
    require  => Package['php55w', 'php55w-opcache', 'php55w-pdo', 'php55w-mcrypt'],
  }

  exec { "Create project ${::laravel::project_name}":
    command     => "php composer.phar create-project laravel/laravel ${::laravel::project_name}",
    environment => ["COMPOSER_HOME=/var/www/html"],
    cwd         => '/var/www/html',
    creates     => "/var/www/html/${::laravel::project_name}",
    require     => Exec['Install composer.phar'],
  }
}
