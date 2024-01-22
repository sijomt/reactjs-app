FROM node:alpine3.18 as build

# Set default values for environment variables
# ENV REACT_APP_NODE_ENV=production
# ENV REACT_APP_SERVER_BASE_URL=http://00.000.000.00:0000

# Build App
WORKDIR /app 
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Serve With Nginx
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build .
EXPOSE 80
ENTRYPOINT [ "nginx", "-g", "daemon off;" ] 