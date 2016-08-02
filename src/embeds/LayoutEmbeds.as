package embeds
{
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class LayoutEmbeds
	{
		static public const TOOL_TIP:Class = null;
		static public const WAITING_TIMER:Class = null;
		static public const RESOURCE_BUBBLE:Class = null;
		static public const TEXT_NOTIFICATION:Class = null;
		
		[Embed(source = "layouts/main_background.json", mimeType = "application/octet-stream")]
		public static const main_background:Class;
		
		[Embed(source = "layouts/window_base.json", mimeType = "application/octet-stream")]
		public static const window_base:Class;
		
		public function LayoutEmbeds()
		{
		
		}
	
	}

}