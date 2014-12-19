class laravel::services {

  service { 'httpd':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
  }
}
