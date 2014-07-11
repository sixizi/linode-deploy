# Simple Linode VPS deployment

Simple linode VPS deployment script

## Usage

Prepare deployment files, then copy the directory to your newly created linode
VPS, and

    # cd linode_deploy
    # ./install.sh

you setup linode server in minutes.

## Notes

This is only a skeleton project. You should add necessary files. Also, you may
modify `pkg.list` to install more packages. You can commit changes into branches
while keep `master` branch clean.

## Tips

To quickly setup a linode VPS for shadowsocks proxy, I put following files

    pkgs/shadowsocks_1.4.6-1_amd64.deb

    etc/shadowsocks/config.json
    service/shadowsocks/run

I use kerberos at home and on VPS', so these files

    etc/krb5.conf
    krb5/k5login
    krb5/krb5.keytab

Use `smokeping` to monitor network loss rate and latency,

    pkgs/smokeping_2.6.8-2_all.deb

    etc/nginx/sites-enabled/sites
    etc/smokeping/config.d/Targets

And, because linode `pv-grub-x86_64` doesn't support xz compression, I had to
package one in gzip compression. You should change kernel to `pv-grub-x86_64`
and reboot

    pkgs/linux-image-3.14-0.bpo.1-amd64_3.14.7-1~bpo70+1_amd64.deb

BTW, running dnsmasq at non-53 port, to help me avoid dns pollution

    etc/dnsmasq.d/settings
