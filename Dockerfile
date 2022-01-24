FROM golang:1.16-alpine as builder
RUN apk update && apk upgrade \
    && apk add --no-cache ca-certificates && update-ca-certificates

WORKDIR /app
COPY . /app/
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app .

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /app/app /app
ADD https://github.com/golang/go/raw/master/lib/time/zoneinfo.zip /zoneinfo.zip
ENV ZONEINFO /zoneinfo.zip
ENTRYPOINT ["/app"]
