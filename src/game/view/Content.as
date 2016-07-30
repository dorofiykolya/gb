package game.view
{
	import feathers.utils.display.calculateScaleRatioToFill;
	import feathers.utils.display.calculateScaleRatioToFit;
	
	/**
	 * ...
	 * @author dorofiy.com
	 */
	public class Content
	{
		
		public function Content()
		{
		
		}
		
		public static function scale(value:Number):Number
		{
			return Math.round(value * globalScale);
		}
		
		public static function get globalScale():Number
		{
			return 1;
		}
		
		public static function calculateScale(originalWidth:Number, originalHeight:Number, targetWidth:Number, targetHeight:Number):Number
		{
			var origin:Number = originalWidth / originalHeight;
			var target:Number = targetWidth / targetHeight;
			
			var widthRatio:Number = targetWidth / originalWidth;
			var heightRatio:Number = targetHeight / originalHeight;
			if (widthRatio < heightRatio && target > origin)
			{
				return widthRatio;
			}
			return heightRatio;
		}
		
		public static function round(value:Number):Number
		{
			return Math.round(value);
		}
		
		public static function get locationScale():Number
		{
			return contentWidth / drawWidth;
		}
		
		public static function get minContentWidth():Number
		{
			//return 540.0;
			//return 640.0;
			return scale(1080.0);
		}
		
		public static function get contentWidth():Number
		{
			//return 640.0;
			//return 768.0;
			return scale(1536.0);
		}
		
		public static function get contentHeight():Number
		{
			//return 960.0;
			//return 1024;
			return scale(2048.0);
		}
		
		public static function get drawWidth():Number
		{
			//return 640.0;
			return scale(1536.0);
		}
		
		public static function get drawHeight():Number
		{
			//return 960.0;
			//return 1024.0;
			return scale(2048.0);
		}
		
		public static function get cardWidth():Number
		{
			return scale(280.0);
		}
		
		public static function get cardHeight():Number
		{
			return scale(411);
		}
	
	}

}