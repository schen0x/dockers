# syntax=docker/dockerfile:1
# ref: https://docs.docker.com/engine/reference/builder/
FROM node:12-alpine
RUN apk add --no-cache python g++ make
# no error when existing, create parent if necessary.
RUN mkdir -p /app
# equivilent to cd /app in the docker, affect all subsequent commands
WORKDIR /app
# 1. The node_modules may have platform dependencies, hence better to build dependencies per micro-service.
# 2. Each line is a layer, use cache unless the dependencies are changed.
COPY ./web/*.json ./
RUN npm install
# the $PORT will be available for all subsequent instructions and in the final image.
ENV PORT=8080
EXPOSE 8080
# CMD ["node", "src/index.js"]
CMD ["npm", "run", "dev"]
# CMD ls -la /app && echo $PORT && npm run dev
