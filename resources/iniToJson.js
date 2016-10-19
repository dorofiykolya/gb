var fs = require("fs");
var path = require("path");
if(process.argv.length == 3)
{
	var ini = process.argv[2];
	var json = parse(ini);
	console.log(json);
}

function parse(ini)
{
	var result = {};
	var current = result;
	var lines = ini.replace("\r\n", "\n").split("\n");
	for (var i = 0; i < lines.length; i++) 
	{
		var trimmed = trim(lines[i]);
		var left = trimmed.charAt(0);
		var right = trimmed.charAt(trimmed.length - 1);
		if (left == "#" || left == ";")
		{
			//ignore comment
		}
		else if (left == "[" && right == "]")
		{
			// start block
			var property = trim(trimmed.slice(1, trimmed.length - 1));
			current = {};
			result[property] = current;
		}
		else
		{
			var keyValue = trimmed.split("=");
			current[trim(keyValue[0])] = trim(((keyValue.length > 1)? keyValue[1] : ""));
		}
	}
	return result;
}

function isWhitespace(character)
{
	switch (character)
	{
		case " ": 
		case "\t": 
		case "\r": 
		case "\n": 
		case "\f": 
			return true;
	}
	return false;
}

function trim(text)
{
	var startIndex = 0;
	while (isWhitespace(text.charAt(startIndex)))
	{
		++startIndex;
	}
	var endIndex = text.length - 1;
	while (isWhitespace(text.charAt(endIndex)))
	{
		--endIndex;
	}
	if (endIndex >= startIndex)
	{
		return text.slice(startIndex, endIndex + 1);
	}
	return "";
}