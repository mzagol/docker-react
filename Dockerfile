# Start first image
# Specify a base image and name it for later use
FROM node:16-alpine AS builder

# Define project root
WORKDIR /app

# Install depenendencies
# Copy package.json from the host to the container
# Run npm install in the container
# Copy project files from the host to the container - this allows for updates to the project files locally without re-installing project dependencies
COPY package.json .
RUN npm install
COPY . .

# Execute npm build command
RUN npm run build

# Start second imsage
# Specify a base image
FROM nginx

# Copy 'npm run build' result from the first named image to the nginx web root on the second image
COPY --from=builder /app/build /usr/share/nginx/html

# CMD is not needed since nginx image startup command starts Nginx web server
