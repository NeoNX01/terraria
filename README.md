```
docker run -it -p 7777:7777 \
    -v $HOME/terraria/config:/config \
    --name=terraria \
    docker.pkg.github.com/neonx01/terraria/terraria-server
```

Took things from https://github.com/beardedio/terraria and the forked repo
