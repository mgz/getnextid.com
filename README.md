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
