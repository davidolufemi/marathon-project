FROM node:18-alpine

# Set working directory
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy package files and install dependencies
COPY Backend/package*.json ./Backend/
WORKDIR /app/Backend
RUN npm install

# Copy backend and frontend code
WORKDIR /app
COPY Backend ./Backend
COPY Frontend ./Frontend

# Set permissions and drop to non-root user
RUN chown -R appuser:appgroup /app
USER appuser

# Set final working directory
WORKDIR /app/Backend

# Expose port and run app
EXPOSE 3000
CMD ["node", "index.js"]
