return {
	-- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
	ssh_domains = {
		{
			name = "vlti",
			remote_address = "162.105.156.33",
			username = "vlti",
			remote_wezterm_path = "/data/vlti/bin/wezterm",
		},
		{
			name = "vlti_vpn",
			-- remote_address = "162.105.156.33",
			remote_address = "172.16.2.100",
			username = "vlti",
			remote_wezterm_path = "/data/vlti/bin/wezterm",
		},
	},

	-- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
	unix_domains = {},

	-- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
}
