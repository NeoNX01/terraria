FROM mono

# Update and install a zip utility
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vim zip && \
    apt-get clean

# fix for favorites.json error
RUN favorites_path="/root/My Games/Terraria" && mkdir -p "$favorites_path" && echo "{}" > "$favorites_path/favorites.json"

# Download and install Terraria
ENV VANILLA_VERSION=1353

RUN mkdir /tmp/terraria && \
    cd /tmp/terraria && \
    curl -sL http://terraria.org/server/terraria-server-$VANILLA_VERSION.zip --output terraria-server.zip && \
    unzip -q terraria-server.zip && \
    mv */Linux /vanilla && \
    mv */Windows/serverconfig.txt /vanilla/serverconfig-default.txt && \
    rm -R /tmp/* && \
    chmod +x /vanilla/TerrariaServer* && \
    if [ ! -f /vanilla/TerrariaServer ]; then echo "Missing /vanilla/TerrariaServer"; exit 1; fi

COPY run-vanilla.sh /vanilla/run.sh

# Commit Hash Metadata
ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/beardedio/terraria"

# Allow for external data
VOLUME ["/config"]

# Run the server
WORKDIR /vanilla
CMD ["./run.sh"]
