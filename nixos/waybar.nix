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
					format = "{:%b %d  %H:%M}";
					format-alt = " {:%a %b %d, %G}";
				};
			};
		};
	};
}
