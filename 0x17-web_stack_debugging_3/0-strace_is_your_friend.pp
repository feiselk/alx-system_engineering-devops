# puppet code to fix WordPress webstack bug
exec {'fix wordpress':
  command => 'sed -i s/phpp/php/g /var/www/html/wp-settings.php',
  path    => '/usr/local/bin/:/bin/'
  }
