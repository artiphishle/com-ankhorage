const { exec } = require('child_process');

exec('sh scripts/starter-expo-stack.sh',
  (error, stdout, stderr) => {
    if(!stdout) return;
    console.log(stdout);
  });
