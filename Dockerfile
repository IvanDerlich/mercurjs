FROM ubuntu:24.04

RUN apt-get update && apt-get install -y curl ca-certificates unzip && \
	rm -rf /var/lib/apt/lists/* && \
	curl -fsSL https://bun.sh/install | bash

ENV PATH="/root/.bun/bin:${PATH}"

# RUN bunx @mercurjs/cli@latest create my-marketplace

# RUN cd my-marketplace

# RUN bun run dev

# WORKDIR /my-marketplace

EXPOSE 9000 7000 7001

CMD ["sleep", "infinity"]