#!/usr/bin/env node

const exec = require("child_process").exec;
exec("./scripts/starter-expo-stack.sh", (a,b,c)=>{
  if(a) console.log(a);
  if(b) console.log(b);
  if(c) console.log(c);
});
