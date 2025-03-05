# Use an official Node.js image as a base
FROM node:18-alpine AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project
COPY . .

# Build the React app
RUN npm run build

# Use Nginx to serve the build files
FROM nginx:alpine

# Copy build files to Nginx directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port Nginx runs on
EXPOSE 8000

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
