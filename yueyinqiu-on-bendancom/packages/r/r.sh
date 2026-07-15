dir="${XDG_CONFIG_HOME:-$HOME/.config}/r"
if [ "$#" -eq 0 ]; then
    echo "Available commands:"
    for f in "$dir"/*.sh; do
        if [ -f "$f" ]; then
            echo "  $(basename "$f" .sh)"
        fi
    done
else
    exec sh "$dir/${1}.sh" "${@:2}"
fi
