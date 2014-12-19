# === Class: laravel
#
# The main class of managing Laravel Framework
#
# === Parameters
#
#[*project_name*]
#  Name of project
#  Default: 'super.local'
#
#[*server_alias*]
#  Aliases for project.conf
#  Default: 'www.super.local zzz'
#
# === Examples
#
# class { 'laravel':
#   project_name => 'super.local',
#   server_alias => 'www.super.local zzz',
# }
#
# OR
#
# include laravel
#
# === Authors
#
# Vasyl Mykhailyshyn (fullhaus1991@gmail.com)
#

class laravel (
    $project_name = 'mymoviedb.local',
    $server_alias = 'www.mymoviedb.local www'
) {
    # All aliases for virtual hosts(locate templates->project.conf.erb)
    $all_alias = "${::ipaddress} ${::laravel::project_name} ${::laravel::server_alias}"
    
    Class['laravel::packages'] -> Class['laravel::configs'] ~> Class['laravel::services']
    include laravel::packages
    include laravel::configs
    include laravel::services
}
