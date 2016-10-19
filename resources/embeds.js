var fs = require("fs");
var path = require("path");

var PACKAGE_KEY = "${PACKAGE}";
var CLASS_KEY = "${CLASS}";
var EMBEDS_KEY = "${EMBEDS}";

var PATH_KEY = "${PATH}";
var FILE_NAME_KEY = "${FILE_NAME}";
var FILE_EXT_KEY = "${FILE_EXT}";
var MIME_TYPE_KEY = "${MIME_TYPE}";

var templateFile = fs.readFileSync("templates/ClassEmbeds.tmpl", "utf8");
var templateEmbed = fs.readFileSync("templates/Embed.tmpl", "utf8");

if(process.argv.length != 7)
{
	console.log("error arguments. args: folder:String className:String package:String saveFile:String embedPath:String");
	return;
}

var folder = process.argv[2];
var className = process.argv[3];
var packageName = process.argv[4];
var saveFile = process.argv[5];
var embedPath = process.argv[6];

console.log("arguments: " + process.argv);

var files = fs.readdirSync(folder);

console.log("files: " + files);

var embeds = "";
for (var prop in files) 
{
    var p = path.join(folder, files[prop]);
    if(!fs.statSync(p).isDirectory())
    {
        var file = files[prop];
        var ext = path.extname(file);
        var fileName = path.basename(p, ext);
        
        var mimeType = "";
        switch(ext)
        {
            case ".png":
            case ".jpg":
            case ".jpeg":
            case ".bmp":
            case ".mp3":
                mimeType = "";
                break;
            default:
                mimeType = ", mimeType = \"application/octet-stream\"";
                break;
        }
        
        embeds += templateEmbed.replace(PATH_KEY, embedPath).replace(FILE_NAME_KEY, fileName).replace(FILE_NAME_KEY, fileName).replace(FILE_EXT_KEY, ext).replace(MIME_TYPE_KEY, mimeType);
        embeds += "\r\n";
    }
}

var fileContent = templateFile.replace(EMBEDS_KEY, embeds).replace(CLASS_KEY, className).replace(CLASS_KEY, className).replace(PACKAGE_KEY, packageName);
fs.writeFileSync(saveFile, fileContent, "utf8");

console.log("DONE!");