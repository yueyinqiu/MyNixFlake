if [ "$#" -ne 1 ]; then
    echo "Usage: ./home.sh <name>" >&2
    exit 1
fi

expected="$(whoami)-on-$(hostname)"

if [[ "$expected" != "$1" ]]; then
    echo "The given name ($1) does not match the expected one ($expected)."
    read -p "Are you sure to continue? [y/N] " answer
    case "$answer" in
        [yY][eE][sS]|[yY]) ;;
        *) echo "Cancelled."; exit 1 ;;
    esac
fi

home-manager switch --flake ".#$1"