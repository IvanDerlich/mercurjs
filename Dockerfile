# syntax=docker/dockerfile:1.7

FROM ubuntu:24.04

ARG NODE_MAJOR=22

RUN apt-get update

RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y gnupg
RUN apt-get install -y unzip
RUN apt-get install -y git
RUN apt-get install -y postgresql-client

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list

RUN apt-get update
RUN apt-get install -y nodejs

# Install Bun runtime and make it available globally.
ENV BUN_INSTALL=/root/.bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH=${BUN_INSTALL}/bin:${PATH}
RUN bun --version

RUN corepack enable
RUN node --version
RUN npm --version

RUN rm -rf /var/lib/apt/lists/*

RUN npm i -g @mercurjs/cli@2.0.0
# RUN npm i -g @medusajs/medusa-cli@1.3.23


# RUN npx @mercurjs/cli create my-marketplace \
# 	--template basic \
# 	--skip-email \
# 	--db-connection-string "postgresql://appuser:change_me_strong@localhost:5432/appdb"
    # --skip-db
# 	--db-connection-string "postgresql://appuser:change_me_strong@localhost:5432/appdb"

# RUN npm i @medusajs/medusa-cli@1.3.23

# RUN cd my-marketplace

# RUN npm run dev

# WORKDIR /my-marketplace

# EXPOSE 9000 7000 7001

CMD ["sleep", "infinity"]