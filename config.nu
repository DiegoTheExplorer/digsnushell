# config.nu
#
# Installed by:
# version = "0.105.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

#env vars
$env.config.buffer_editor = "nvim"
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
# prevents scrolling on keypress in Wezterm on Windows
$env.config.shell_integration.osc133 = false 
# prevents the first-timer welcome banner from displaying
$env.config.show_banner = false
$env.yazi_config_home = 'C:\Users\DMVil\.config\yazi\config\'
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional


#yazi file explore with cd/z
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

#create the vendor (3rd party plugin) autoload directory
mkdir ($nu.data-dir | path join "vendor/autoload")

#create 3rd party plugin sub config files
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
carapace _carapace nushell | save --force ($nu.data-dir | path join "vendor/autoload/carapace.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

neofetch
