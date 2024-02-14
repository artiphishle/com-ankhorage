#!/usr/bin/env node

'use strict';

const file = fs.createWriteStream("starter-expo-stack");
const request = http.get("https://github.com/artiphishle/starter-expo-stack", function(response) {
   response.pipe(file);

   // after download completed close filestream
   file.on("finish", () => {
       file.close();
       console.log("Download Completed");
   });
});
