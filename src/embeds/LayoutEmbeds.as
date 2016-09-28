package embeds
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LayoutEmbeds
	{
		static public const TOOL_TIP:Class = Class;
		static public const WAITING_TIMER:Class = Class;
		static public const RESOURCE_BUBBLE:Class = Class;
		static public const TEXT_NOTIFICATION:Class = Class;
		
		[Embed(source = "layouts/main_background.json", mimeType = "application/octet-stream")]
		public static const main_background:Class;
		
		[Embed(source = "layouts/window_base.json", mimeType = "application/octet-stream")]
		public static const window_base:Class;
		
		public function LayoutEmbeds()
		{
		
		}
	
	}

}