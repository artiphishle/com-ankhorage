#!/usr/bin/env node
const path = require("path");
const { exec } = require('child_process');
const scriptPath = path.join(__dirname, "scripts", "starter-expo-stack.sh");

exec(scriptPath, (error, stdout, stderr) => {
  if (error) return console.error(`Error: ${error.message}`);
  if (stderr) return console.error(`Error: ${stderr}`);
  console.log(stdout);
});
