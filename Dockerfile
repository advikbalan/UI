# Base image: Use a lightweight Node.js image
FROM node:lts-alpine

COPY dist /app
WORKDIR /app

# Expose the port that the app will run on
EXPOSE 8080
  
# Start the Node.js server
CMD ["node", "server.js"]