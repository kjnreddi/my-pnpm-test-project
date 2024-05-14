# Use an official Node.js runtime as a parent image
FROM node:latest

ADD package.json /tmp/package.json
# Set the working directory in the container
RUN --mount=type=secret,id=npm-token,target=/root/.npmrc
RUN cd /tmp && npm install -g pnpm && pnpm --version && pnpm install && mkdir -p /microservice && cp -a /tmp/node_modules /microservice

WORKDIR /microservice
ADD . /microservice

RUN ls

# Make port 3000 available to the world outs ide this container
EXPOSE 3000

#RUN chmod +x /microservice/entrypoint.sh
#ENTRYPOINT ["/microservice/entrypoint.sh"]

# Define the command to run your app using CMD which sets your runtime
CMD ["node", "index.js"]