# etc configuration files that i wanted stored

# created symbolic links to point at the home files
```bash
sudo ln -sfn /home/youruser/etc/greetd/config.toml  /etc/greetd/config.toml
sudo ln -sfn /home/youruser/etc/tuigreet/config.toml /etc/tuigreet/config.toml
sudo ln -sfn /home/youruser/scripts/run_tuigreet.sh /usr/local/bin/run_tuigreet.sh

sudo chown youruser:users ~/etc/greetd/config.toml
sudo chown youruser:users ~/etc/tuigreet/config.toml
sudo chown youruser:users ~/scripts/run_tuigreet.sh

chmod 755 ~/etc/greetd/config.toml
chmod 755 ~/etc/tuigreet/config.toml
chmod 755 ~/scripts/run_tuigreet.sh
sudo setfacl -m u:greeter:x /home/youruser
```

