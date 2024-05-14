# Use an official Node.js runtime as a parent image
FROM node:latest

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# Enable corepack
RUN corepack enable

RUN mkdir -p /microservice
WORKDIR /microservice
ADD . /microservice

# Set the working directory in the container
RUN --mount=type=secret,id=npm-token,target=/root/.npmrc
RUN cd /microservice && pnpm install
RUN pnpm run build

# Make port 3000 available to the world outs ide this container
EXPOSE 3000


# Define the command to run your app using CMD which sets your runtime
CMD ["node", "index.js"]