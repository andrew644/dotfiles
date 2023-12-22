{ ... }:
{
	programs.wofi = {
		enable = true;
		settings = {
			mode = "drun";
			allow_images = true;
		};
		style = ''
* {
	border-radius: 5px;
	border: none;
}

window {
	font-size: 32px;
	font-family: monospace;
	background-color: rgba(50, 50, 50, 0.9);
	color: white;
}

#entry {
	padding: 0.25em;
}

#entry:selected {
	background-color: #bbccdd;
	background: linear-gradient(90deg, #bbccdd, #cca5dd);
}

#text:selected {
	color: #333333;
}

#input {
	background-color: rgba(50, 50, 50, 0.5);
	color: white;
	padding: 0.25em;
}

image {
	margin-left: .25em;
	margin-right: .25em;
}
		'';
	};
}
