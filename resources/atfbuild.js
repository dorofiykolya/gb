var fs = require("fs");
var path = require("path");
var exec = require('child_process');

console.log(process.argv);

var exe = process.argv[2]; 
var compression = process.argv[3];
var argsFiles = process.argv.slice(4, process.argv.length);
var files = [];
var done = 0;

for (var prop in argsFiles) 
{
    getAllFiles(argsFiles[prop], files);
}

for (var prop in files) 
{
    processFile(files[prop]);
}

var id = setInterval(function()
{
    if(done == files.length)
    {
        clearInterval(id);
        id.unref();
        process.exit(0);
    }
}, 1000).ref();

function getCompression(value)
{
	switch(value)
	{
		case "a": return "";
		case "all": return "";
		case "bmp": return "";
		case "png": return "";
		case "e": return "-c e";
		case "etc": return "-c e";
		case "android": return "-c e";
		case "e2": return "-c e2";
		case "etc2": return "-c e2";
		case "d": return "-c d";
		case "dxt": return "-c d";
		case "browser": return "-c d";
		case "windows": return "-c d";
		case "mac": return "-c d";
		case "p": return "-c p";
		case "ios": return "-c p";
		case "pvr": return "-c p";
	}
	return "";
}

function processFile(file) 
{
    exec.exec([exe, getCompression(compression), "0,0", "-r", "-i", file, "-o", file.replace(".png", ".atf")].join(" "), (error, stdout, stderr) => 
    {
      if (error) 
      {
        console.error(error);
        done++;
        return;
      }
      console.log(stdout);
      console.log(stderr);
    }).on("close", function(e)
    {
        done++;
        console.log("done: " + file);
        console.log("remaining files: " + (files.length - done));
    });
}

function getAllFiles(dir, result)
{
    var files = fs.readdirSync(dir);
    
    for (var prop in files) 
    {
        var p = path.join(dir, files[prop]);
        if(fs.statSync(p).isDirectory())
        {
            getAllFiles(p, result);
        }
        else if(path.extname(p) == ".png")
        {
            result[result.length] = p;
        }
    }
}