This repository contains a fork of [Privaxy](https://github.com/Barre/privaxy) v0.3.1 that has been dockerized and pushed to GitHub Container Registry (ghcr) for easy deployment. The main purpose is to maintain the web UI functionality from the original Privaxy v0.3.1 release. By containerizing Privaxy, it can now be easily run on a server using the ghcr image.

## Installation and Usage

The front end code expects the `IP_ADDRESS` environment variable to be defined, otherwise it will default to `0.0.0.0` which will break functionality. To use the web portal remotely, be sure to define `IP_ADDRESS` to the host computer's address. This is required for the front end components like certificate links to work properly. The back end proxy server will still function without IP_ADDRESS defined, but the front end will be broken

### Using prebuilt docker image

1. Change the IP address to your server IP address `docker-compose.yml`
2. `docker-compose up`

### Local

1.  ` docker build -t webui-privaxy .`
2.  (Optional) `export IP_ADDRESS=<SERVER IP ADDRESS>`
3.  ```bash
    docker run -d \
       --name webui-privaxy \
       -p 8000:8000 \
       -p 8100:8100 \
       -p 8200:8200 \
       -e "IP_ADDRESS=<SERVER IP ADDRESS>"
       webui-privaxy
    ```

### Disclaimer

Similar to the original version, there is no authentication for the proxy or webUI. The best way to access this remotely outside of your home is with something like Tailscale or Wireguard.

## TODO

- [ ] Update files to match Privaxy updates since v0.3.1
- [ ] Automatic network binding so IP_ADDRESS does not need to be declared
- [ ] Add Cloudflare tunneling (Cloudflare One) for authentication

## From the original repo, still relevant to this fork.

### Using the rust toolchain

1. Begin by [installing rust](https://www.rust-lang.org/tools/install).

2. Install rust's wasm target: `rustup target add wasm32-unknown-unknown`

3. [Install trunk](https://trunkrs.dev/#install).

4. [Install nodejs as well as npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm) (at least v14).

5. Clone this repository.

6. Build the web gui by running `cd web_frontend && npm i && trunk build --release && cd ..`

7. Build the server by running `cd privaxy && cargo build --release.`

8. Run privaxy using `cargo run --release --bin privaxy`.

### Local system configuration

1. Navigate to the web gui at `http://127.0.0.1:8000`, click on "Download CA certificate".

2. Install the downloaded certificate locally.

- Macos: <https://support.apple.com/guide/keychain-access/add-certificates-to-a-keychain-kyca2431/mac>

- Linux: `cp privaxy_ca_certificate.pem /usr/local/share/ca-certificates/`

3. Configure your local system to pass http traffic through privaxy.

- Macos: <https://support.apple.com/guide/mac-help/change-proxy-settings-network-preferences-mac-mchlp2591/mac>

- Ubuntu (gnome): <https://phoenixnap.com/kb/ubuntu-proxy-settings>

## About

Privaxy is a MITM HTTP(s) proxy that sits in between HTTP(s) talking applications, such as a web browser and HTTP servers, such as those serving websites.

By establishing a two-way tunnel between both ends, Privaxy is able to block network requests based on URL patterns and to inject scripts as well as styles into HTML documents.

Operating at a lower level, Privaxy is both more efficient as well as more streamlined than browser add-on-based blockers. A single instance of Privaxy on a small virtual machine, server or even, on the same computer as the traffic is originating from, can filter thousands of requests per second while requiring a very small amount of memory.

Privaxy is not limited by the browser’s APIs and can operate with any HTTP traffic, not only the traffic flowing from web browsers.

Privaxy is also way more capable than DNS-based blockers as it is able to operate directly on URLs and to inject resources into web pages.

## Features

- Suppport for [Adblock Plus filters](https://adblockplus.org/filter-cheatsheet), such as [easylist](https://easylist.to/).

- Web graphical user interface with a statistics display as well as a live request explorer.

- Support for uBlock origin's `js` syntax.

- Support for uBlock origin's `redirect` syntax.

- Support for uBlock origin's scriptlets.

- Browser and HTTP client agnostic.

- Support for custom filters.

- Support for excluding hosts from the MITM pipeline.

- Support for protocol upgrades, such as with websockets.

- Automatic filter lists updates.

- Very low resource usage.

- Around 50MB of memory with approximately 320 000 filters enabled.

- Able to filter thousands of requests per second on a small machine.
