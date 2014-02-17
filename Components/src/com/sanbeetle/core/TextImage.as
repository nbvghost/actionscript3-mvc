package com.sanbeetle.core
{
	import flash.display.Sprite;
	import flash.net.URLVariables;
	
	public class TextImage extends Sprite
	{
		private var _imageData:URLVariables;
		public function TextImage()
		{
			super();
		}

		public function get imageData():URLVariables
		{
			return _imageData;
		}

		public function set imageData(value:URLVariables):void
		{
			_imageData = value;
		}

	}
}