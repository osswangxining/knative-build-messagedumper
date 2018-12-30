FROM registry.cn-hangzhou.aliyuncs.com/wangxining/golang:latest AS builder
RUN mkdir -p /go/src/knative-build-messagedumper
COPY ./main.go /go/src/knative-build-messagedumper/
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o /go/bin/knative-build-messagedumper ./src/knative-build-messagedumper

FROM alpine:latest
COPY --from=builder /go/bin/knative-build-messagedumper /knative-build-messagedumper
WORKDIR /
ENTRYPOINT ["/knative-build-messagedumper"]
