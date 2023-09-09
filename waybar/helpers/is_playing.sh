is_playing() {
	if [ $(playerctl status) == "Playing" ]; then
		return 0
	else
		return 1
	fi
}

is_playing
