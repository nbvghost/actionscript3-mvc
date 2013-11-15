package com.sanbeetle
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	
	/**
	 *
	 *@author sixf
	 */
	public class Component
	{
		private var _TimerRunTime:int = 100;
		private var _Style:String = "";
		private var _ilabelFilters:Array;
		private var _ibuttonFilters:Array;
		private var _irightMenuFilters:Array;
		private var _isideBoxFilters:Array;
		
		/**
		 * list  菜单 消失时间，毫秒
		 */
		public var LIST_HIDE_TIME:int = 100;
		
		private var _debug:Boolean = true;
		
		private static var _component:Component;
		public function Component ()
		{
			
			_ilabelFilters = [new DropShadowFilter(1,60,0x000000,0.3,1,1,1,BitmapFilterQuality.LOW,false,false)];
			_ibuttonFilters = [new DropShadowFilter(1,60,0x000000,0.3,1,1,1,BitmapFilterQuality.LOW,false,false)];
			_irightMenuFilters = [new DropShadowFilter(5,90,0x000000,0.3,15,15,1,BitmapFilterQuality.LOW,false,false)];
			_isideBoxFilters = [new DropShadowFilter(5,90,0x000000,0.3,15,15,1,BitmapFilterQuality.LOW,false,false)];
			/*Console.setOutCallBack (function (...ages):void{
				if(ages[0]=="components10"){
					//Console.out("sdfds");
				}
			});*/
			
		}
		
		
		
		public function get debug ():Boolean
		{
			return _debug;
		}
		
		public function set debug (value:Boolean):void
		{
			_debug = value;
		}
		
		/**
		 *  [new DropShadowFilter(5, 90, 0x000000, 0.3, 15, 15, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get isideBoxFilters ():Array
		{
			return _isideBoxFilters;
		}
		
		public function set isideBoxFilters (value:Array):void
		{
			_isideBoxFilters = value;
		}
		
		/**
		 * [new DropShadowFilter(5, 90, 0x000000, 0.3, 15, 15, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get irightMenuFilters ():Array
		{
			return _irightMenuFilters;
		}
		
		public function set irightMenuFilters (value:Array):void
		{
			_irightMenuFilters = value;
		}
		
		/**
		 * [new DropShadowFilter(1, 60, 0x000000, 0.3, 1, 1, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get ibuttonFilters ():Array
		{
			return _ibuttonFilters;
		}
		
		public function set ibuttonFilters (value:Array):void
		{
			_ibuttonFilters = value;
		}
		
		/**
		 * [new DropShadowFilter(1, 60, 0x000000, 0.3, 1, 1, 1,BitmapFilterQuality.LOW, false, false)]; 
		 * @return 
		 * 
		 */
		public function get ilabelFilters ():Array
		{
			return _ilabelFilters;
		}
		
		public function set ilabelFilters (value:Array):void
		{
			_ilabelFilters = value;
		}
		
		public function get TimerRunTime ():int
		{
			return _TimerRunTime;
		}
		
		public function set TimerRunTime (value:int):void
		{
			_TimerRunTime = value;
		}
		
		/**
		 *  样式表
		 */
		public function get Style ():String
		{
			return _Style;
		}
		
		/**
		 * @private
		 */
		public function set Style (value:String):void
		{
			_Style = value;
		}
		
		public function initStyle (style:String):void
		{
			_Style = style;
		}
		public static function get component ():Component
		{
			if (_component==null)
			{
				_component =new Component();
			}
			return _component;
		}
	}
}