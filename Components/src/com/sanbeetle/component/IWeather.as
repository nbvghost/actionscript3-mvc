package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IWeatherSkin;
	
	
	public class IWeather extends UIComponent {
		
		public static const wt_none:String="-";
		public static const wt_l:String="冷";
		public static const wt_r:String="热";
		public static const wt_y:String="雨";
		public static const wt_x:String="雪";
		public static const wt_wh:String="温和";
		
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
			
			switch(_weather){
				case wt_none:
					skin.gotoAndStop(1);
					break;
				case wt_l:
					skin.gotoAndStop(2);
					break;
				case wt_r:
					skin.gotoAndStop(3);
					break;
				case wt_y:
					skin.gotoAndStop(4);
					break;
				case wt_x:
					skin.gotoAndStop(5);
					break;
				case wt_wh:
					skin.gotoAndStop(6);
					break;
			}
			
		}
		
		override protected function createUI():void
		{
			this.addChild(skin);
		}
		
		
	}
	
}
