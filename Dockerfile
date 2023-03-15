# # pull official base image
# FROM node:17.9.0

# # set working directory
# WORKDIR /app

# # install app dependencies
# COPY package.json ./
# COPY package-lock.json ./
# RUN npm install

# EXPOSE 3000

# # add app
# COPY . ./

# # start app
# CMD ["npm", "start"]

# Original
# FROM node:17.9.0 as build
FROM node:16.15.1 as build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 1 - Serve Frontend Assets
# FROM nginx:1.19.10
FROM nginx:1.23.0

#Original 
COPY ./nginx.conf /etc/nginx.conf
COPY --from=build /app/build /usr/share/nginx/html

