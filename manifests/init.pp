class nethook {

  $dependencies = ['perl-App-Daemon', 'perl-IO-Interface', 'perl-Log-Log4perl']

  $directories = ['/etc/nethook', '/etc/nethook/ifup.d', '/etc/nethook/ifdown.d']

  package { $dependencies:
    ensure => installed,
  }

  file { $directories:
    ensure => directory,
  }

  file { '/usr/local/sbin/nethook':
    mode => '0755',
    source => 'puppet:///modules/nethook/nethook',
    require => Package[$dependencies],
  }

  file { '/etc/init.d/nethook':
    mode => '0755',
    source => 'puppet:///modules/nethook/sysv',
    require => File['/usr/local/sbin/nethook'],
  }

  service { 'nethook':
    enable => true,
    ensure => running,
    require => [ File['/usr/local/sbin/nethook'], File['/etc/init.d/nethook'] ],
  }

}
