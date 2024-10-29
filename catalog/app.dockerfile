FROM golang:1.23.2-nanoserver-1809 AS build
RUN apk --no-cache add gcc g++ make ca-certificates
WORKDIR /go/src/github.com/careofyou/go-grpc
COPY go.mod go.sum ./
COPY vendor vendor 
COPY account account 
RUN GO111MODULE=on go build -mod vendor -o /go/bin/app ./account/cmd/catalog

FROM nanoserver-1809 
WORKDIR /usr/bin
COPY --from=build /go/bin .
EXPOSE 8080
CMD ["app"]
