# Prepare build image
FROM node:14-alpine AS build

# Install git package
#RUN apt-get update && apt-get install -y git
RUN apk update && apk upgrade && apk add git

# Clone project
RUN git clone https://gitlab.com/bbwrl/m347-ref-card-02

# Set working directory
WORKDIR /m347-ref-card-02

# Install dependencies
RUN npm install

# Build the app
RUN npm run build



# Prepare Production Image
FROM nginx:latest

# Copy the build directory from build image to Nginx image
COPY --from=build /m347-ref-card-02/build/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
