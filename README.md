# Polka

Development configuration for Luckie & Co.

## Dependencies

* Homebrew
* Git
* Bash ~> 4.2

## Setup Bash 4.2

```sh
brew install bash
sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
```
The next step is crucial but cannot be completed on network accounts

```sh
chsh -s /usr/local/bin/bash
```
