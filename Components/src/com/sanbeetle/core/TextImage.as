package com.sanbeetle.core
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	public class TextImage extends Sprite
	{
		private var _imageData:URLVariables;
		private var _boundaries:Rectangle;
		
		private var loader:Loader;
		
		private var content:DisplayObject;
		
		public function TextImage()
		{
			super();
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
		}
		
		protected function onCompleteHandler(event:Event):void
		{
			
			content =  loader.content;
			content.width = _boundaries.width;
			content.height = _boundaries.height;
			
			this.addChild(content);
			
		}
		
		public function get boundaries():Rectangle
		{
			return _boundaries;
		}

		public function setBoundaries(value:Rectangle):void
		{
			_boundaries = value;
			
			if(content){
				content.width = _boundaries.width;
				content.height = _boundaries.height;	
			}
			this.graphics.clear();
			this.graphics.beginFill(0xff0000);
			this.graphics.drawRect(0,0,_boundaries.width,_boundaries.height);
			this.graphics.endFill();
		}

		public function get imageData():URLVariables
		{
			return _imageData;
		}

		public function setImageData(value:URLVariables):void
		{
			_imageData = value;
			
			loader.load(new URLRequest(_imageData.src));
			
			
		}

	}
}