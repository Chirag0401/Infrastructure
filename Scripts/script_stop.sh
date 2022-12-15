#!/bin/bash
pid=$(sudo pm2 pid app)
if [ $pid == 0 ]; then
   echo "Application is stopped"
else
   echo "Application is running"
   cd /home/ubuntu/node-express-realworld-example-app
   pm2 stop app.js
   echo "Application is stopped"
fi