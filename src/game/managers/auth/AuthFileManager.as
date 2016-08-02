package game.managers.auth
{
	import common.events.Event;
	import common.events.EventDispatcher;
	import common.system.text.StringUtil;
	import common.system.utils.ObjectUtils;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	[Event(name = "ioError", type = "common.events.Event")]
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class AuthFileManager extends EventDispatcher
	{
		private static const FILE_PATH:String = "auth.key";
		
		private var _type:Class;
		
		public function AuthFileManager(authType:Class)
		{
			_type = authType;
		}
		
		public function write(value:Object):void
		{
			if (value == null || !(value is _type))
			{
				throw new ArgumentError("value must can't bee null or not equals authType");
			}
			var result:String = serialize(value);
			try
			{
				var stream:FileStream = new FileStream();
				stream.open(authFile, FileMode.WRITE);
				stream.writeUTFBytes(result);
				stream.close();
			}
			catch (error:Error)
			{
				dispatchEventWith(Event.IO_ERROR, false, error);
			}
		}
		
		public function read():Object
		{
			if (existAuthFile)
			{
				var stream:FileStream = new FileStream();
				var opened:Boolean;
				try
				{
					stream.open(authFile, FileMode.READ);
					opened = true;
					stream.position = 0;
					var result:String = stream.readUTFBytes(stream.bytesAvailable);
					stream.close();
					stream = null;
					return deserialize(result);
				}
				catch (error:Error)
				{
					dispatchEventWith(Event.IO_ERROR, false, error);
				}
				finally
				{
					if (stream && opened)
					{
						stream.close();
					}
				}
			}
			return null;
		}
		
		public function get existAuthFile():Boolean
		{
			return authFile.exists;
		}
		
		private function serialize(value:Object):String
		{
			return JSON.stringify(ObjectUtils.toObject(value));
		}
		
		private function deserialize(value:String):Object
		{
			if (!StringUtil.isEmpty(value))
			{
				try
				{
					var json:Object = JSON.parse(value);
					return ObjectUtils.toType(json, _type);
				}
				catch (error:Error)
				{
					dispatchEventWith(Event.IO_ERROR, false, error);
				}
			}
			return null;
		}
		
		private function get authFile():File
		{
			return File.applicationStorageDirectory.resolvePath(FILE_PATH);
		}
	
	}

}