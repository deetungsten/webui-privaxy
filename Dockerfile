# Use the official Rust image as the base
FROM rust:latest

# Install wasm32-unknown-unknown target for Rust
RUN rustup target add wasm32-unknown-unknown

RUN apt-get update && apt-get install -y nodejs npm

RUN cargo install trunk

# Create mount point for certificates  
VOLUME /.cache/webui-privaxy

# Set working directory
WORKDIR /app

# Copy the local repository into the Docker image
COPY . /app

# Build the web gui
RUN cd web_frontend && npm i && npm install -g trunk && trunk build --release

# Build the server
RUN cd privaxy && cargo build --release

# Set the entrypoint to run privaxy
CMD cargo run --release --bin privaxy