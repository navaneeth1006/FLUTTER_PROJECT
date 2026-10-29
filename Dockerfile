# -------------------------------------------------------------
# Stage 1: Build Flutter Web release
# -------------------------------------------------------------
FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

# Cache dependency layer
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy source code and build for web
COPY . .
RUN flutter build web --release

# -------------------------------------------------------------
# Stage 2: Serve using optimized Nginx container
# -------------------------------------------------------------
FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy custom Nginx configuration with SPA routing and cache headers
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build artifacts from previous stage
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
