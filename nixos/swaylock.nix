{ ... }:

{
	programs.swaylock = {
		enable = false;
		settings = {
			color = "001223";
			show-failed-attempts = true;
			indicator-caps-lock = true;
			ignore-empty-password = true;
			indicator-radius = 300;
			indicator-thickness = 30;
			font-size = 30;
		};
	};
}
