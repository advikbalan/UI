# Stage 1: Build the Angular application
FROM node:20 AS build-stage

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files from api-catalog directory
COPY api-catalog/package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application's source code from api-catalog directory
COPY api-catalog/ .

# Build the Angular app in production mode
RUN npm run build

# Stage 2: Serve the Angular application with NGINX
FROM nginx:alpine AS production-stage

# Set the working directory for NGINX
WORKDIR /usr/share/nginx/html

# Remove the default NGINX static content
RUN rm -rf ./*

# Copy the build output from the first stage to NGINX's HTML folder
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
