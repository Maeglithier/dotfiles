// Stop giving errors PLEASE!!!
WebAudio = { prototype: "a" };
Bitmap = { prototype: "a" };
Game_Interpreter = { prototype: "a" };
Graphics = { prototype: "a" };

const _gamePath = process.argv[2];

// Search for compatible files
function findBottomLevelFolder(filepath, search) {
  const fs = require("fs");
  const decodeFile = require("./POR_AssetDecoder");
  var files = fs.readdirSync(filepath);
  for (var i in files) {
    var path = filepath + files[i];
    try {
      findBottomLevelFolder(path + "/", search);
    } catch (e) {
      var rightFormat = false;
      for (var j in search) if (path.includes(search[j])) rightFormat = true;
      if (rightFormat) {
        var file = fs.readFileSync(path);
        // Decode with the plugin params
        console.log("Decrypting:", path);
        decodeFile(file);
        var newPath = path.replace(/o$/, "");
        fs.writeFileSync(newPath, file);
        console.log("Decrypted:", newPath);
      }
    }
  }
}

// Search for audios, images and videos
findBottomLevelFolder(_gamePath + "/www/audio/", [".m4ao", ".oggo"]);
findBottomLevelFolder(_gamePath + "/www/img/", [".pngo"]);
findBottomLevelFolder(_gamePath + "/www/movies/", [".webmo", ".mp4o"]);
