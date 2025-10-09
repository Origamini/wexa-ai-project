# Use the official Node.js image
FROM node:20-alpine AS build

# Install git so we can clone the repo
RUN apk add --no-cache git

# Set working directory
WORKDIR /app

# Clone your GitHub repo (replace with your actual repo URL)
RUN git clone https://github.com/kavitha351/wexa-ai-project.git .

# Install dependencies
RUN npm install

# Build the Next.js app
RUN npm run build

# Use a lightweight Node image for running
FROM node:20-alpine AS runner

# Set working directory
WORKDIR /app

# Copy the built app from previous stage
COPY --from=build /app ./

# Expose the port
EXPOSE 3000

# Set environment variable for production
ENV NODE_ENV=production

# Start the Next.js app

CMD ["npm", "start"]
