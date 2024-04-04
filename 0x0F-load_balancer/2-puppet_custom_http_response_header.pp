# File: 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define a custom Nginx configuration template
file { '/etc/nginx/sites-available/custom_header.conf':
  ensure  => present,
  content => template('nginx/custom_header.conf.erb'),
}

# Symbolically link the custom configuration file to sites-enabled
file { '/etc/nginx/sites-enabled/custom_header.conf':
  ensure => link,
  target => '/etc/nginx/sites-available/custom_header.conf',
  require => File['/etc/nginx/sites-available/custom_header.conf'],
}

# Ensure Nginx service is running and reload it when configuration changes
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-enabled/custom_header.conf'],
}
