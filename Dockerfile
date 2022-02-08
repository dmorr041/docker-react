FROM node:16-alpine AS build
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# When the container above is done building, it places the build inside of <WORKDIR>/build, or /app/build
# Then, below, this container will take the build project from the build stage contianer, and place it into
# the static html dir for nginx, and then start nginx (starting nginx is the default command for the nginx image)
COPY --from=build /app/build /usr/share/nginx/html