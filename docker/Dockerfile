# Use a small web server base image
FROM nginx:alpine

# Set working directory inside container
WORKDIR /usr/share/nginx/html

# Copy your HTML and CSS into container
COPY index.html .
COPY style.css .   # only if you have

# Expose port 80
EXPOSE 80
