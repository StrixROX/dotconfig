cliptext() {
	local text="${1}"
	local clippedText="$(cut -c 1-$2 <<< ${text})"
	if [ ${#text} != ${#clippedText} ]; then
		echo "${clippedText}..."
	else
		echo "${text}"
	fi
}

is_playing() {
        if [ $(playerctl status) == "Playing" ]; then
                return 0
        else
                return 1
        fi
}

if [ $1 == "title" ]; then
	cliptext "$(playerctl metadata title)" 20
elif [ $1 == "artist" ]; then
	cliptext "$(playerctl metadata artist)" 20
elif [ $1 == "album" ]; then
	cliptext "$(playerctl metadata album)" 20
elif [ $1 == "status" ]; then
	is_playing
fi
