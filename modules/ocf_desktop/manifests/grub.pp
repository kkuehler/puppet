class ocf_desktop::grub {
  # password protection to prevent modifying kernel options
  file { '/etc/grub.d/01_ocf':
    content   => file('/opt/puppet/shares/private/desktop/grub/01_ocf'),
    mode      => '0500',
    show_diff => false,
    notify    => Exec['update-grub'];
  }

  exec {
    # only require password to modify commandline or access grub console
    'sed -i \'s/^CLASS="/CLASS="--unrestricted /\' /etc/grub.d/10_linux':
      unless => 'grep \'^CLASS="--unrestricted \' /etc/grub.d/10_linux',
      notify => Exec['update-grub'];

    'update-grub':
      refreshonly => true;
  }
}
