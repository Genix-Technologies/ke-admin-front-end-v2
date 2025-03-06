# Use a multi-stage build to optimize image size
FROM node:18 AS builder

WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm install

COPY . .

# Build your application (including Tailwind CSS)
RUN npm run build
RUN ls -la /app #Add this line.
# Final stage: Run the application
FROM node:18-alpine

WORKDIR /app

# Copy only the necessary files from the builder stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist 
# Or your build output directory
COPY --from=builder /app/public ./public 
#if you have a public folder.
COPY --from=builder /app/src ./src 
# if required for your application.
# Set environment variables (if needed)
ENV NODE_ENV production

EXPOSE 3000 
# Or the port your application uses

CMD ["npm", "start"]