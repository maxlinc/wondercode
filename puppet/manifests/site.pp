node default {
  $deploy_user  = "wondercode"
  $rbenv_user   = $deploy_user
  $ruby_version = "2.0.0-p247"

  include nodejs

  # User creation
  user { $deploy_user:
    managehome => true,
    ensure => present,
    shell => '/bin/bash',
  }

  file { ["/opt/apps", "/opt/apps/releases", "/opt/apps/releases/0", "/opt/apps/releases/0/config"]:
    ensure => "directory",
    owner  => $deploy_user,
    mode   => 750,
  }

  file { "/opt/apps/current":
    ensure => link,
    target => "/opt/apps/releases/0",
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
  rbenv::compile { $ruby_version:
    user => $rbenv_user,
    global => true,
    require => Rbenv::Plugin::RubyBuild[$rbenv_user]
  }

  unicorn::app { 'wondercode':
    # We don't want to start right away
    ensure             => 'stopped',
    approot            => '/opt/apps/current',
    pidfile            => '/opt/apps/current/tmp/pids/unicorn.pid',
    socket             => '/opt/apps/current/tmp/pids/unicornunicorn.sock',
    user               => 'wondercode',
    group              => 'wondercode',
    preload_app        => true,
    rack_env           => 'production',
    use_binstubs       => true,
    source             => 'bundler',
    require            => [
      # Class['ruby::dev'],
      # Bundler::Install[$app_root],
    ],
  }
}
