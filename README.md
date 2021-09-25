# HOWTO

## Dependencies

* [nvchecker](https://github.com/lilydjwg/nvchecker) (version >=2.3)
* Config-specific (most of them are probably already installed): `coreutils`, `curl`, `grep`, `iconv`, `perl`, `sed`

## `source.toml`

This is the "main" nvchecker-related file you'll need to modify. It has a lot of apps that are interesting to me, so you'll most likely remove most of them. But feel free to use them as source of "inspiration" to write your own configs! :)

## `new.json` & `old.json`

Check out the [nvchecker documentation](https://nvchecker.readthedocs.io/en/latest/usage.html#version-record-files).

## Creating your own `keys.toml`

1. Generate a [GitHub token](https://github.com/settings/tokens) (no additional API scopes needed) if you don't have one.
2. Create a new `keys.toml` file inside this repository:

    ```toml
    [keys]
    github = "YOUR GITHUB TOKEN HERE"
    ```

## Enabling the systemd timer

The systemd timer/service is useful to automatically check for new app updates. By default, I have set the timer to run every hour, but that's [configurable](https://www.freedesktop.org/software/systemd/man/systemd.time.html).

1. Edit the `nvchecker.service` file inside the `systemd/` directory on this repository.
2. Search for the following line:

    ```ini
    WorkingDirectory=%h/Projects/github/nvchecker
    ```
3. `%h` is a [systemd specifier](https://www.freedesktop.org/software/systemd/man/systemd.unit.html#Specifiers) that points to your home folder, i.e. `/home/john`.
    So, in short, you'll have to change that path to wherever folder on your computer you have cloned this git repository to.
4. Copy both `nvchecker.{service,timer}` files to systemd's [unit search path](https://www.freedesktop.org/software/systemd/man/systemd.unit.html#User%20Unit%20Search%20Path):
    ```bash
    mkdir -p ~/.config/systemd/user
    cp systemd/nvchecker.{service,timer} ~/.config/systemd/user
    ```
5. Reload systemd's user service daemon:
    ```bash
    systemctl --user daemon-reload
    ```
6. Enable the timer:
    ```bash
    systemctl --user enable nvchecker.timer --now
    ```
7. If there is any app update, you should get a nice desktop notification, like this:

![Image](../blob/master/etc/notification.png?raw=true)