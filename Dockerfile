# Stage 1: Build the Angular application
FROM node:20 AS build-stage

# Set working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application's source code to the container
COPY . .

# Build the Angular app in production mode
RUN npm run build

# Stage 2: Serve the Angular application with NGINX
FROM nginx:alpine AS production-stage

# Copy the build output from the previous stage to the NGINX www directory
COPY --from=build-stage /app/dist/your-angular-app-name /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]
