package components
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.controls.Image;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	import mx.events.RSLEvent;
	import mx.preloaders.DownloadProgressBar;
	import mx.preloaders.SparkDownloadProgressBar;
	import flash.display.DisplayObject;
	
	public class Loading extends SparkDownloadProgressBar
	{  
		public function Loading()  
		{  
			
			super();  
			 
			
		}  
		private var logo:Loader;  
	    private var _preloader:Sprite;  
		 
		[Embed(source="assets/1024_768.jpg")]   //进度条的背景图片  
		[Bindable]  
		private var bcgImageClass: Class;  
		
		override public function get backgroundImage():Object{   
			 return bcgImageClass;     //背景图片  
		}  
		override public function get backgroundSize():String{  
		     return "100%"; //背景的尺寸，背景默认的尺寸是充满整个舞台的  
		}  
		 
		override public function get stageHeight():Number
		{
	 	     return Capabilities.screenResolutionY;
		 
		}
		
		override public function get stageWidth():Number
		{
		 	return Capabilities.screenResolutionX;
		 
		}
		 
		
		override protected function showDisplayForDownloading(
			elapsedTime:int, event:ProgressEvent):Boolean {
			
		 	return true;
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			//super.createChildren();
			if (backgroundImage != null)
				loadBackgroundImage(backgroundImage);
			 return;
		}
		
		private function loadBackgroundImage(classOrString:Object):void
		{
			var cls:Class;
			
			// The "as" operator checks to see if classOrString
			// can be coerced to a Class
			if (classOrString && classOrString as Class)
			{
				// Load background image given a class pointer
				cls = Class(classOrString);
				initBackgroundImage(new cls());
			}
			 
		}
		private function initBackgroundImage(image:DisplayObject):void
		{
			addChildAt(image,0);
			
			var backgroundImageWidth:Number = image.width;
			var backgroundImageHeight:Number = image.height;
			
			// Scale according to backgroundSize
			var percentage:Number = calcBackgroundSize();
			if (isNaN(percentage))
			{
				var sX:Number = 1.0;
				var sY:Number = 1.0;
			}
			else
			{
				var scale:Number = percentage * 0.01;
				sX = scale * stageWidth / backgroundImageWidth;
				sY = scale * stageHeight / backgroundImageHeight;
			}
			
			image.scaleX = sX;
			image.scaleY = sY;
			
			// Center everything.
			// Use a scrollRect to position and clip the image.
			var offsetX:Number =
				Math.round(0.5 * (stageWidth - backgroundImageWidth * sX));
			var offsetY:Number =
				Math.round(0.5 * (stageHeight - backgroundImageHeight * sY));
			
			image.x = offsetX;
			image.y = offsetY;
			
			// Adjust alpha to match backgroundAlpha
			if (!isNaN(backgroundAlpha))
				image.alpha = backgroundAlpha;
		}
		private function calcBackgroundSize():Number
		{   
			var percentage:Number = NaN;
			
			if (backgroundSize)
			{
				var index:int = backgroundSize.indexOf("%");
				if (index != -1)
					percentage = Number(backgroundSize.substr(0, index));
			}
			
			return percentage;
		}
		
		
		override public function initialize():void
		{
			// TODO Auto Generated method stub
			 
			stage.stageWidth=Capabilities.screenResolutionX;   
			stage.stageHeight= Capabilities.screenResolutionY; 
			 
			super.initialize();
		//	trace("initialize"+stage.stageWidth+","+stage.stageHeight);
	 
		}
		override protected function setDownloadProgress(completed:Number, total:Number):void
		{
			 
				return;
			
		 
		}
		override protected function setInitProgress(completed:Number, total:Number):void
		{
			return;
		}
	 /*
		override public function set preloader(value:Sprite):void{  
		 
	 	 	_preloader = value;
		 
		  	_preloader.addEventListener(ProgressEvent.PROGRESS,load_progress);  
		  	_preloader.addEventListener(Event.COMPLETE,load_complete);  
		  	_preloader.addEventListener(FlexEvent.INIT_PROGRESS,init_progress);  
		     _preloader.addEventListener(FlexEvent.INIT_COMPLETE,init_complete);  
		 
	 
		}  
	 
		private function remove():void{  
			_preloader.removeEventListener(ProgressEvent.PROGRESS,load_progress);  
			_preloader.removeEventListener(Event.COMPLETE,load_complete);  
			_preloader.removeEventListener(FlexEvent.INIT_PROGRESS,init_progress);  
			_preloader.removeEventListener(FlexEvent.INIT_COMPLETE,init_complete);  
		 
		}  
		
		private function load_progress(e:ProgressEvent):void{  
	     	trace("正在加载..."+int(e.bytesLoaded/e.bytesTotal*100)+"%");
			 
		 }  
		private function load_complete(e:Event):void{  
	 
		}  
		private function init_progress(e:FlexEvent):void{  
	 
		}  
		private function init_complete(e:FlexEvent):void{  
		 
			remove();  
			dispatchEvent(new Event(Event.COMPLETE));  
		}   */
	 
	}   
}