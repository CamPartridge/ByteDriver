# FROM node:16

# COPY . .

# RUN npm cache clean --force
# RUN npm install

# ENV PORT=8080

# EXPOSE 8080

# CMD [ "npm", "start" ]

# Use the Node.js 16-slim base image
FROM node:16-slim

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json if present
COPY package.json package-lock.json* ./

# Clean npm cache to avoid potential issues
RUN npm cache clean --force

# Delete package-lock.json and node_modules (optional but can help)
RUN rm -rf package-lock.json node_modules

# Install the dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Define the command to run the application
CMD ["npm", "start"]