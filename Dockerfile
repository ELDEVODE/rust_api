FROM rust:1.75 AS builder
WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

FROM debian:buster-slim
RUN apt-get update && apt-get install -y libssl-dev && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/src/app/target/release/rust_api /usr/local/bin/rust_api
EXPOSE 8080
CMD ["rust_api"]
