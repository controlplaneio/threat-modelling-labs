FROM golang:1.19-bullseye AS builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY *.go ./
RUN go build -o /hello_world

FROM gcr.io/distroless/base-debian11
WORKDIR /
COPY --from=builder /hello_world /hello_world
EXPOSE 8080
ENTRYPOINT ["/hello_world"]