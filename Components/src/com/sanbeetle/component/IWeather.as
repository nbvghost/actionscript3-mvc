package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IWeatherSkin;
	
	
	public class IWeather extends UIComponent {
		
		private var _weather:String="-";
		private var skin:IWeatherSkin;
		public function IWeather() {
			skin = new IWeatherSkin();
		}
		[Inspectable(enumeration = "-,冷,热,雨,雪,温和",defaultValue = "-")]		
		public function get weather():String
		{
			return _weather;
		}
		public function set weather(value:String):void
		{
			_weather = value;
			
		}
		
		override protected function createUI():void
		{
			this.addChild(skin);
		}
		
		
	}
	
}
