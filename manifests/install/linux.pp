class filebeat::install::linux {
  package {'filebeat':
    ensure => $filebeat::package_ensure,
  }

  # FIXME: hack since the package currently doesn't support SLES11
  # https://github.com/elastic/beats/issues/737
  if $::osfamily == 'Suse' and versioncmp($::operatingsystemrelease, '12') < 0 {
    file { '/etc/rc.d/init.d':
      ensure => directory,
    } ->
    file { '/etc/rc.d/init.d/functions':
      source => 'puppet:///modules/filebeat/functions'
    }
  }
}
