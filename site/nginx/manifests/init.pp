class nginx inherits nginx::params{
File {
  owner => 'root',
  group => 'root',
  mode => '0664',
 } 
 package { 'nginx':
   ensure => present,
  }
  file { '/var/www':
    ensure => directory,
  }
  file {'/var/www/index.html':
    ensure => file,
    source => ${nginx::index_html_source},
  }
  file {'/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file {'/etc/nginx/conf.d':
    ensure => 'directory',
  }
 file {'/etc/nginx/conf.d/default.conf':
   ensure => file,
   source => 'puppet:///modules/nginx/default.conf',
   require => Package['nginx'],
   notify => Service['nginx'],
   }
   
  service { 'nginx':
    ensure => running,
    enable => true,
  }  
}
  
   
