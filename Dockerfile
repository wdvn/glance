FROM golang:1.24.0-bullseye AS builder

WORKDIR /app

ADD . .

RUN go mod tidy && go mod vendor

RUN CGO_ENABLED=0 go build -o glance .

FROM debian:12-slim

WORKDIR /app

COPY --from=builder /app/glance .

EXPOSE 8080/tcp

CMD ["/app/glance"]
