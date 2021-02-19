FROM golang:latest AS builder
ENV GO111MODULE on
ENV GOPROXY https://goproxy.cn
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -a -o server .


FROM alpine:latest AS final
WORKDIR /app
COPY --from=builder /build/server /app/
EXPOSE 9999
ENTRYPOINT ["/app/server"]