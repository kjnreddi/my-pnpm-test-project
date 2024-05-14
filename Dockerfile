# Use an official Node.js runtime as a parent image
FROM node:latest

# Set environment variables for pnpm
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# Enable corepack
RUN corepack enable

# Install pnpm globally
RUN npm install -g pnpm --force

# Set the working directory for the build step
WORKDIR /microservice

# Copy package.json and pnpm-lock.yaml to install dependencies
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN --mount=type=secret,id=npm-token,target=/root/.npmrc && pnpm install

# Copy the rest of the application code
COPY . .

# Expose the application port (replace 3000 with your application's port if different)
EXPOSE 3000

# Run the application
CMD ["npm", "start"]