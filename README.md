This repo contains complete source code of the application. 

# How to use:

Get current counter value:
```bash
$ curl -s "http://getnextid.com/counter/your.counter.name?auth=YOUR_PASSWORD"
1
```

Increment counter and get new value:
```bash
$ curl -s -X POST "http://getnextid.com/counter/your.counter.name?auth=YOUR_PASSWORD"
2
```

Ruby gem: https://github.com/mgz/getnextid-ruby


# Running app in Docker yourself
### Clone and build docker image:
```
git clone git@github.com:mgz/getnextid.com.git && cd getnextid.com && \
docker build -t getnextid.com . && \
docker volume create postgres_data && \
docker run --name getnextid.com --rm -p 3118:80 -it -v `pwd`/postgres_data:/var/lib/postgresql getnextid.com
```
### Open app in browser:
Navigate to http://localhost:3118
