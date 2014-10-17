#!/bin/sh

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales

apt-get purge -qqy rpcbind
sed -i 's,wheezy,jessie,g' /etc/apt/sources.list
apt-get -qq update; apt-get -qqy dist-upgrade
apt-get -qqy install $(cat pkg.list)

if [ -d pkgs ]; then
	dpkg -i pkgs/*.deb; apt-get -qqy install -f
fi

if [ -d etc ]; then
	tar -cf - etc | tar -C / -xf -
fi

mkdir -p /boot/grub; update-grub; sed -i 's,UUID=[a-f0-9\-]* ,/dev/xvda console=hvc0 ,g' /boot/grub/menu.lst; update-grub

if [ -f /etc/default/shadowsocks ]; then
	/etc/init.d/shadowsocks stop; sed -i 's,^START=yes,START=no,g' /etc/default/shadowsocks
fi

if [ -d etc/nginx ]; then
	nginx -s reload
fi

cat sshd_config >> /etc/ssh/sshd_config
test -f krb5/krb5.keytab && cp -a krb5/krb5.keytab /etc/krb5.keytab
test -f krb5/k5login && cp -a krb5/k5login ~/.k5login
/etc/init.d/ssh restart

test -f bashrc && cp -a bashrc ~/.bashrc
