package game.managers.dragonBones
{
	import common.system.ClassType;
	import common.system.reflection.Constant;
	import dragonBones.Armature;
	import dragonBones.core.IArmature;
	import dragonBones.fast.FastArmature;
	import dragonBones.objects.DragonBonesData;
	import dragonBones.objects.ObjectDataParser;
	import dragonBones.objects.XMLDataParser;
	import dragonBones.starling.StarlingFactory;
	import dragonBones.starling.StarlingTextureAtlas;
	import dragonBones.textures.ITextureAtlas;
	import embeds.DBAtlasEmbed;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import game.modules.assets.IAssetProvider;
	import game.modules.assets.IAssetsManager;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class DragonBonesFactory implements IDBFactory
	{
		[Inject]
		public var assets:IAssetsManager;
		
		private var _factory:StarlingFactory;
		private var _cacheByName:Dictionary;
		private var _cacheByType:Dictionary;
		private var _cacheAtlas:Dictionary;
		private var _map:Dictionary;
		private var _mapValue:Dictionary;
		private var _mapAtlas:Dictionary;
		
		public function DragonBonesFactory()
		{
			_factory = new StarlingFactory();
			_cacheByName = new Dictionary();
			_cacheByType = new Dictionary();
			_map = new Dictionary();
			_mapValue = new Dictionary();
			_mapAtlas = new Dictionary();
			_cacheAtlas = new Dictionary();
		}
		
		private function registerData(data:Object):DragonBonesData
		{
			var isName:Boolean = data is String && data in _map;
			var isType:Boolean = data is Class && data in _mapValue;
			var name:String;
			var result:DragonBonesData;
			
			if (isName)
			{
				result = _cacheByName[data];
				name = String(data);
			}
			else if (isType)
			{
				result = _cacheByType[data];
				name = String(_mapValue[data]);
			}
			
			if (result == null)
			{
				var parseData:Object = data;
				if (isName)
				{
					parseData = _map[name];
				}
				else if (isType)
				{
					parseData = data;
				}
				if (parseData is Class)
				{
					parseData = new (Class(parseData));
				}
				if (parseData is ByteArray)
				{
					parseData = String(ByteArray(parseData).readUTFBytes(ByteArray(parseData).bytesAvailable));
				}
				if (parseData is String)
				{
					if (String(parseData).charAt(0) == "{")
					{
						parseData = JSON.parse(String(parseData));
						result = ObjectDataParser.parseDragonBonesData(Object(parseData));
					}
					else
					{
						parseData = new XML(String(parseData));
						result = XMLDataParser.parseDragonBonesData(XML(parseData));
					}
				}
				
				if (isName)
				{
					_cacheByName[data] = result;
				}
				else if (isType)
				{
					_cacheByType[data] = result;
				}
				
				_factory.addSkeletonData(result, name);
			}
			return result;
		}
		
		private function registerAtlas(name:String):void
		{
			var atlas:StarlingTextureAtlas = _cacheAtlas[name];
			if (atlas == null)
			{
				var clazz:Class;
				var data:Object = _mapAtlas[name];
				if (data is Class)
				{
					clazz = Class(data);
					data = new clazz();
				}
				if (data is ByteArray)
				{
					data = String(ByteArray(data).readUTFBytes(ByteArray(data).bytesAvailable));
				}
				if (data is String)
				{
					if (String(data).charAt(0) == "<")
					{
						data = new XML(data);
					}
					else
					{
						data = JSON.parse(String(data));
					}
					atlas = new StarlingTextureAtlas(assets.getTextureAtlas(name).texture, data, true);
					_factory.addTextureAtlas(atlas, name);
					_cacheAtlas[name] = atlas;
				}
				else
				{
					throw new ArgumentError("[game.managers.dragonBones.DragonBonesFactory][registerAtlas]");
				}
			}
		}
		
		private function getName(data:Object):String
		{
			var isName:Boolean = data is String && data in _map;
			var isType:Boolean = data is Class && data in _mapValue;
			var name:String;
			
			if (isName)
			{
				name = String(data);
			}
			else if (isType)
			{
				name = String(_mapValue[data]);
			}
			
			return name;
		}
		
		public function buildFastArmature(data:Object):FastArmature
		{
			var name:String = getName(data);
			registerData(data);
			registerAtlas(name);
			return _factory.buildFastArmature(name, null, name);
		}
		
		public function buildArmature(data:Object):Armature
		{
			var name:String = getName(data);
			registerData(data);
			registerAtlas(name);
			return _factory.buildArmature(name, null, name);
		}
		
		public function mapFromType(type:Class):void
		{
			var constants:Vector.<Constant> = ClassType.getClassType(type).constants;
			for each (var item:Constant in constants)
			{
				map(item.name, type[item.name]);
			}
		}
		
		public function map(name:String, value:Object):void
		{
			_map[name] = value;
			_mapValue[value] = name;
		}
		
		public function mapAtlasFromType(type:Class):void
		{
			var constants:Vector.<Constant> = ClassType.getClassType(type).constants;
			for each (var item:Constant in constants)
			{
				_mapAtlas[item.name] = type[item.name];
			}
		}
	
	}

}