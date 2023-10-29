# Selects a container by fzf, then run it.
fdup() {
	local cid
	cid=$(
		docker ps -a |
			fzf -m --header-lines=1 |
			awk '{print $NF}'
	)
	[ -n "$cid" ] && echo $cid | xargs docker-compose up
}

# Selects a container by fzf, then remove it.
fdrm() {
	local cid
	cid=$(
		docker ps -a |
			sed 1d |
			fzf -m -q "$1" |
			awk '{print $1}'
	)
	[ -n "$cid" ] && echo $cid | xargs docker rm -f
}

# Selects a image by fzf, then run it.
docker-run() {
	local container
	container="$(docker image ls | sed -e '1d' | fzf --height 40% --reverse | awk -v 'OFS=:' '{print $1,$2}')"
	if [ -n "${container}" ]; then
		echo "runing container from ${container} ..."
		docker container run -it --rm ${container}
	fi
}

# Selects a image by fzf, then remove it.
fdrmi() {
	local cid
	cid=$(
		docker images |
			fzf -m --header-lines=1 |
			awk '{print $3}'
	)
	[ -n "$cid" ] && echo $cid | xargs docker rmi
}
