package game
{
	import game.modules.applications.IApplicationDescription;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class GameDescription implements IApplicationDescription
	{
		[Embed(source = "../../application.xml", mimeType = "application/octet-stream")]
		private static const APP_DESCRIPTOR:Class;
		
		private var _runtimeVersion:String;
		private var _applicationID:String;
		private var _applicationDescriptor:XML;
		
		public function GameDescription()
		{
			var xml:XML = new XML(new APP_DESCRIPTOR);
			if (xml)
			{
				_applicationDescriptor = xml;
				var children:XMLList = xml.children();
				var name:QName;
				for (var i:int = 0; i < children.length(); i++) 
				{
					name = children[i].name() as QName;
					if (name && name.localName == "versionNumber")
					{
						_runtimeVersion = children[i].text();
					}
					if (name && name.localName == "id")
					{
						_applicationID = children[i].text();
					}
				}
			}
			else
			{
				_applicationDescriptor = null;
				_runtimeVersion = "0.0.1";
				_applicationID = "PiratesRoyal";
			}
		}
		
		/* INTERFACE game.modules.applications.IApplicationDescription */
		
		public function get runtimeVersion():String 
		{
			return _runtimeVersion;
		}
		
		public function get applicationDescriptor():XML
		{
			return _applicationDescriptor;
		}
		
		public function get applicationID():String
		{
			return _applicationID;
		}
	}
}