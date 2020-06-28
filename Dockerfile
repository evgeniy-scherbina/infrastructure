FROM lightningnetwork/golang-alpine:latest

COPY . /go/src/github.com/evgeniy-scherbina/infrastructure

WORKDIR /go/src/github.com/evgeniy-scherbina/infrastructure
RUN go install ./src/back-end/services/hello
