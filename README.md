# Docker CloudForecast

## description

CloudForecast all-in-one docker image, including gearman-job-server.

- https://github.com/kazeburo/cloudforecast


## usage

```
docker run -d -p 5000:5000 \
    -v /path/to/config:/var/lib/cloudforecast/config \
    nekoya/cloudforecast
```
