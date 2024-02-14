#!/usr/bin/env node
const { exec } = require('child_process');

exec('sh scripts/starter-expo-stack.sh', (error, stdout, stderr) => {
  if (error) return console.error(`Error: ${error.message}`);
  if (stderr) return console.error(`Error: ${stderr}`);
  console.log(stdout);
});
