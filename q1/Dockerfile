FROM debian:buster-slim

# Define environment variables
ENV BITCOIN_DATA /data
ENV BITCOIN_URL https://bitcoin.org/bin/bitcoin-core-22.0/bitcoin-22.0-x86_64-linux-gnu.tar.gz
ENV BITCOIN_SHA256 59ebd25dd82a51638b7a6bb914586201e67db67b919b2a1ff08925a7936d1b16 

# Create the user to run the app
RUN groupadd -r bitcoin \
  && useradd -m -g bitcoin bitcoin

# Install requirements with apt
RUN apt-get update \
  && apt-get install -y ca-certificates gosu wget \
  && rm -rf /var/lib/apt/lists/*

# Download, check against expected SHA256 signature, and install bitcoin-core binaries
RUN set -ex \
  && cd /tmp \
  && wget -qO bitcoin.tar.gz "$BITCOIN_URL" \
  && echo "$BITCOIN_SHA256 bitcoin.tar.gz" | sha256sum -c - \
  && tar -xzvf bitcoin.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
  && rm -rf /tmp/*

# Create data directory and set ownership
RUN mkdir "$BITCOIN_DATA" \
  && chown -R bitcoin:bitcoin "$BITCOIN_DATA" \
  && ln -sfn "$BITCOIN_DATA" /home/bitcoin/.bitcoin \
  && chown -h bitcoin:bitcoin /home/bitcoin/.bitcoin

# Expose the port and run the app
EXPOSE 8333
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["/usr/sbin/gosu bitcoin bitcoind"]
