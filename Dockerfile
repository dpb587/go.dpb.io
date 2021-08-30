FROM golang AS build
ENV CGO_ENABLED=0
ENV GOBIN=/tmp
RUN go install go.dpb.io/importshttp/cmd/server@latest

FROM scratch
COPY --from=build /tmp/server /app/bin/server
COPY config.yaml /app/etc/config.yaml
EXPOSE 8080
ENTRYPOINT ["/app/bin/server", "-config=/app/etc/config.yaml"]
