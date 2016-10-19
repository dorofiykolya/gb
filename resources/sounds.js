var fs = require("fs");
var path = require("path");

var templateFile = "package\r\n" + 
"{\r\n" +
	"\timport flash.display.Sprite;\r\n" +
	"\tpublic class SoundsExternalEmbeds extends Sprite\r\n" +
	"\t{\r\n" +
		
		"{content}\r\n" +
		
		"\t\tpublic function SoundsExternalEmbeds()\r\n" +
		"\t\t{\r\n" +
		"\t\t}\r\n" +
	"\t}\r\n" +
"}";

var templateEmbed = "\t\t[Embed(source = \"sounds/{file}.mp3\")]\r\n\t\tpublic static const {file}:Class;";

var folder = process.argv[2];
var fileName = process.argv[3];

console.log("arguments: " + process.argv);

var files = fs.readdirSync(folder);

console.log("files: " + files);

var embeds = "";
for (var prop in files) 
{
    var file = files[prop];
    var name = path.basename(file, ".mp3");
    embeds += templateEmbed.replace(/{file}/g, name);
    embeds += "\r\n";
}

var fileContent = templateFile.replace("{content}", embeds);
fs.writeFileSync(fileName, fileContent);

console.log("DONE!");