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
				modules-center = [ "hyprland/window" ];
				modules-right = [ "battery" "tray" "clock" ];

				"hyprland/workspaces" = {
					format = "{name}";
					on-click = "activate";
					disable-scroll = true;
				};

				battery = {
					states = {
						warning = 30;
						critical = 15;
					};
					format = "{capacity}%";
				};
			};
		};
	};
}
