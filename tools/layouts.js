var fs = require("fs");
var path = require("path");
var scale = 0.5;
var properties =      ["contentWidth", "contentHeight", "width", "height", "x", "y", "pivotX", "pivotY"];
var propertiesSkip =  [null, null, null, null, null, null, null, null];
var propertiesRound = [true, true, true, true, true, true, true, true];

var folder = process.argv[2];
var files = fs.readdirSync(folder);
for (var fileProp in files) 
{
    parseFile(path.join(folder, files[fileProp]));
}

function parseFile(fileName)
{
    if(path.extname(fileName) == ".json")
    {
        var file = fs.readFileSync(fileName);
        var layout = JSON.parse(file);
        parseRoot(layout);
        parseTree(layout.layout);
        fs.writeFileSync(fileName, JSON.stringify(layout, null, 2));
    }
}

function parseRoot(child) 
{
    var canvasSize = child.setting.canvasSize;
    scaleProperty(canvasSize, "x");
    scaleProperty(canvasSize, "y");
}

function parseTree(child)
{
    var params = child.params;
    for (var prop in properties) 
    {
        scaleProperty(params, properties[prop], propertiesSkip[prop], propertiesRound[prop]);
    }
    
    if(params.layout && params.layout.params)
    {
        scaleProperty(params.layout.params, "gap", null, true);
    }
    
    if(child.hasOwnProperty("children"))
    {
        var children = child.children;
        for (var childIndex in children) {
            parseTree(children[childIndex]);
        }
    }
}

function scaleProperty(target, property, ifNotExist, round)
{
    if(target.hasOwnProperty(property) && (!ifNotExist || !target.hasOwnProperty(ifNotExist)))
    {
        var value = target[property];
        value *= scale;
        if(round)
        {
            value = Math.round(value);
        }
        target[property] = value;
    }
}