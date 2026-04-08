# syntax=docker/dockerfile:1.7

FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y ca-certificates
RUN apt-get install -y gnupg
RUN apt-get install -y unzip
RUN apt-get install -y git

# Install Node.js and npm using the NodeSource repository.
ARG NODE_MAJOR
ENV NODE_MAJOR=${NODE_MAJOR}
RUN echo "NODE_MAJOR is: $NODE_MAJOR"

RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_${NODE_MAJOR}.x nodistro main" > /etc/apt/sources.list.d/nodesource.list
RUN apt-get update
RUN apt-get install -y nodejs
# RUN corepack enable
RUN node --version
RUN npm --version

# Install Bun runtime and make it available globally.
ENV BUN_INSTALL=/root/.bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH=${BUN_INSTALL}/bin:${PATH}
RUN bun --version
RUN echo "Bun version: $(bun --version)"

# To test connections manually from the container to the database container
RUN apt-get install -y postgresql-client

# Install Mercur CLI globally using npm.
ARG MERCURJS_VERSION
ENV MERCURJS_VERSION=${MERCURJS_VERSION}
RUN echo "MERCURJS_VERSION is: $MERCURJS_VERSION"
# Keep this version in sync with the package.json of the version you are going to use
# Mercur requires node to be installed globally, otherwise this command fails
# https://github.com/mercurjs/mercur/blob/v${MERCURJS_VERSION}/package.json dependencies
# Otherwise it might cause important issues
# RUN npm i -g @mercurjs/cli@${MERCURJS_VERSION}
RUN git clone https://github.com/mercurjs/mercur.git
RUN cd mercur
RUN bun install

# RUN npm run dev

CMD ["sleep", "infinity"]