var fs = require("fs");
var path = require("path");
var exec = require('child_process');

var defaultScale = 1;
var xmlRoot = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\r\n<data>\r\n${content}</data>";
var xmlElement = "\t<file scale=\"${scale}\">${content}</file>";

var destinationFile = process.argv[2];
var destinationFolder = process.argv[3];
var relativeFolder = process.argv[4];
var argsFiles = process.argv.slice(5, process.argv.length);
var files = [];

collectFiles(argsFiles, files);
var content = getXmlElements(files);
var xml = xmlRoot.replace("${content}", content);

fs.writeFileSync(destinationFile, xml, "utf8");

function getXmlElements(files)
{
    var result = "";
    for (var i in files) 
    {
        var file = files[i];
        var element = xmlElement.replace("${content}", file.path).replace("${scale}", file.scale);
        element += "\r\n";
        result += element;
    }
    return result;
}

function collectFiles(args, resultArray)
{
    for (var prop in args) 
    {
        getAllFiles(args[prop], resultArray);
    }
}

function getAllFiles(dir, result)
{
    if(fs.existsSync(dir))
    {
        var files = fs.readdirSync(dir);
        
        for (var prop in files) 
        {
            var p = path.join(dir, files[prop]);
            var relative = path.dirname(path.relative(path.join(process.cwd(), relativeFolder), p));
            if(fs.statSync(p).isDirectory())
            {
                getAllFiles(p, result);
            }
            else if(path.extname(p) != ".as" && path.extname(p) != ".scale")
            {
                var filePath = 
                {
                    path: path.join(destinationFolder, relative, files[prop]),
                    scale: defaultScale
                };
                if(fs.existsSync(path.join(path.dirname(p), "scale.scale")))
                {
                    filePath.scale = fs.readFileSync(path.join(path.dirname(p), "scale.scale"), "utf8");
                }
                result[result.length] = filePath;
            }
        }
    }
}