FROM node:18

WORKDIR /app

COPY package*.json ./

#RUN npm cache clean --force && npm install
#RUN ls -la node_modules/monaco-editor/min/vs # Check if it exists
#Interactive debug command.
RUN /bin/bash #add this line, then build the image.
RUN npm install cross-env && npm install
COPY . .

CMD ["npm", "start"]