# Use official Node.js LTS image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies (if any in future)
RUN npm install --production

# Copy application code
COPY app.js .

# Expose port (optional, for future web version)
EXPOSE 3000

# Run the application
CMD ["npm", "start"]