node default {
  $deploy_user = "wondercode"
  $rbenv_user = $deploy_user

  include nodejs

  # User creation
  user { $deploy_user:
    managehome => true,
    ensure => present,
    shell => '/bin/bash',
  }

  file { "/opt/apps":
    ensure => "directory",
    owner  => $deploy_user,
    mode   => 750,
  }

  ssh_authorized_key { $deploy_user: 
    user => $deploy_user,
    ensure => present, 
    type => ssh-rsa,
    # Public key for demo
    key => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCvN+kcOdoYQq9+c1QVp9m9PDkCeFPUJY8VMMcyGOphklig90wYclGQfD/xN+d+DykWZi6wpXNv9aZCiAm6MKrk/TGstUhzoRgezasblVHo8Xo2KYPFYuVYx1y0/857LY9FG/ETpvFCaNIm/5agP1ud4Ro6D6nbGX1Wlvs8eD4ypykVMn2lvWcvbJxRgWpPs7h5mNadD8/5CQ/pYlF7pUFhDxv9eIPPvAQRPbAIg1pQxltBeazgeUktF/c6HvPEPvqhauD+rMtznHatTsLxyrmAxe7m+FAj/W/utyA54bh+Fv0wcBF731cAQuRl4KmW0iZgvVztuNpExfupJJJy30XV',
  }

  # Ruby setup
  rbenv::install { $rbenv_user:
    group => $rbenv_user,
  }
  rbenv::plugin::rubybuild { "$rbenv_user":
    user   => $rbenv_user,
    require => Rbenv::Install[$rbenv_user]
  }
  rbenv::compile { "2.0.0-p247":
    user => $rbenv_user,
    global => true,
    require => Rbenv::Plugin::RubyBuild[$rbenv_user]
  }

  unicorn::app { 'wondercode':
    approot     => '/opt/apps/current',
    pidfile     => '/opt/apps/current/tmp/pids/unicorn.pid',
    socket      => '/opt/apps/current/tmp/pids/unicornunicorn.sock',
    user        => 'wondercode',
    group       => 'wondercode',
    preload_app => true,
    rack_env    => 'production',
    source      => 'bundler',
    require     => [
      # Class['ruby::dev'],
      # Bundler::Install[$app_root],
    ],
  }
}
