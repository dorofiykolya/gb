package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
    
    /**
     * ...
     * @author dorofiy.com
     */
    public class Preloader extends MovieClip
    {
		[Embed(source = "embeds/preloader/preloader.jpg")]
		public static const BACKGROUND_CLASS:Class;
		
		[Embed(source = "embeds/preloader/progress.jpg")]
		public static const PROGRESS_CLASS:Class;
		
		private var _background:Bitmap;
		private var _progress:Bitmap;
		private var _progressWidth:Number = 421.0;
		private var _text:TextField;
		
		private const TOTAL:Number = 0.25;
        
        public function Preloader()
        {
			_background = new BACKGROUND_CLASS();
			_background.smoothing = true;
			addChild(_background);
			
			_progress = new PROGRESS_CLASS();
			_progress.smoothing = true;
			_progress.x = 167;
			_progress.y = 573;
			addChild(_progress);
			
			_text = new TextField();
			_text.width = 420;
			_text.height = 100;
			_text.x = 165;
			_text.y = 575;
			_text.defaultTextFormat = new TextFormat(null, 12, 0xffffff, null, null, null, null, null, TextFormatAlign.CENTER);
			_text.selectable = false;
			_text.mouseEnabled = false;
			_text.antiAliasType = AntiAliasType.ADVANCED;
			_text.cacheAsBitmap = true;
			addChild(_text);
			
            if (stage)
            {
                toStageHandler(null);
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, toStageHandler);
            }
            addEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
            loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
            update(0);
        }
        
        private function onEnterFrameHandler(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				removeListeners();
                loadApplication();
			}
		}
        
        private function toStageHandler(event:Event = null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, toStageHandler);
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.RESIZE, onResize);
			updateBitmap();
        }
		
		private function onResize(e:Event):void 
		{
			updateBitmap();
		}
        
        private function onIOErrorHandler(e:IOErrorEvent):void
        {
            trace(e.text);
        }
        
        private function onProgressHandler(e:ProgressEvent):void
        {
            var ratio:Number = e.bytesLoaded / e.bytesTotal;
            update(ratio);
        }
        
        private function update(ratio:Number):void
        {
			_progress.width = _progressWidth * (ratio * TOTAL);
			_text.text = Number((ratio * TOTAL) * 100.0).toFixed(3) + "%";
        }
        
        private function removeListeners():void
        {
            removeEventListener(Event.ENTER_FRAME, onEnterFrameHandler);
            loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgressHandler);
            loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOErrorHandler);
        }
        
        private function loadApplication():void
        {
            var mainClass:Class = Class(getDefinitionByName("Main"));
            stage.addChild(new mainClass() as DisplayObject);
			dispose();
            if (parent)
            {
                parent.removeChild(this);
            }
        }
		
		private function dispose():void
		{
			stage.removeEventListener(Event.RESIZE, onResize);
			
			removeChild(_background);
			removeChild(_progress);
			
			_background.bitmapData.dispose();
			_progress.bitmapData.dispose();
			
			_background = null;
			_progress = null;
		}
		
		private function updateBitmap():void
		{
			if (stage != null)
			{
				scaleX = scaleY = 1;
				scaleX = scaleY = calculateScaleRatioToFill(width, height, stage.stageWidth, stage.stageHeight);
				x = (stage.stageWidth - width) / 2.0;
				y = (stage.stageHeight - height) / 2.0;
			}
		}
		
		public function calculateScaleRatioToFill(originalWidth:Number, originalHeight:Number, targetWidth:Number, targetHeight:Number):Number
		{
			var widthRatio:Number = targetWidth / originalWidth;
			var heightRatio:Number = targetHeight / originalHeight;
			if (widthRatio > heightRatio)
			{
				return widthRatio;
			}
			return heightRatio;
		}
    
    }

}