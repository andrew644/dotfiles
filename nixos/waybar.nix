{ ... }:
{
	programs.waybar = {
		enable = true;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 32;
				modules-left = [ "hyprland/workspaces" ];
				modules-center = [];
				modules-right = [ "pulseaudio" "battery" "tray" "clock" ];

				"hyprland/workspaces" = {
					format = "{name}";
					on-click = "activate";
					disable-scroll = true;
				};

				pulseaudio = {
					format = "{volume:2} {icon}";
					format-muted = "󰝟";
					format-icons = {
						headphones = "";
						default = [
							""
							""
						];
					};
					scroll-step = 5;
				};

				battery = {
					interval = 60;
					states = {
						warning = 30;
						critical = 15;
					};
					format = "{capacity} {icon}";
					format-full = "󱟢";
					format-charging = "{capacity} 󰂄";
					format-icons = [
						"󰂎"
						"󰁼"
						"󰁾"
						"󰂀"
						"󰂂"
					];
				};

				clock = {
					interval = 60;
					align = 0;
					rotate = 0;
					tooltip-format = "<tt><big>{calendar}</big></tt>";
					format = "{:%b %d %H:%M}";
				};
			};
		};
		style = ''
* {
	border: none;
	border-radius: 0;
	font-family: monospace;
	font-size: 15px;
	box-shadow: none;
	text-shadow: none;
	transition-duration: 0s;
}

window {
	color: white;
	background: rgba(50, 50, 50, 0);
}

#workspaces {
	margin: 0 5px;
}

#workspaces button {
	border-radius: 5px;
	margin: 5px 5px 5px 10px;
	padding: 0 5px;
	color: white;
	background: rgba(100, 100, 100, 0.5);
}

#workspaces button.visible {
	color: white;
	background: rgba(50, 50, 50, 0.7);
}

#workspaces button.urgent {
	color: rgba(238, 46, 36, 1);
}

#clock, #battery, #pulseaudio, #tray {
	margin: 5px 5px 5px 5px;
	color: white;
	background: rgba(50, 50, 50, 0.7);
	border-radius: 5px;
	padding: 5px;
}
		'';
	};
}
