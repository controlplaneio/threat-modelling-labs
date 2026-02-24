FROM golang:1.24-bookworm AS builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY *.go ./
RUN go build -o /hello_world

FROM gcr.io/distroless/base-debian12
WORKDIR /
COPY --from=builder --chown=nonroot:nonroot /hello_world /hello_world
EXPOSE 8080
USER nonroot
ENTRYPOINT ["/hello_world"]
