package com.sanbeetle.core
{
	import com.sanbeetle.component.IToolTip;

	public class CacheDispaly
	{
		private static var cache:Object = new Object();
		
		private static var _iTooltip:IToolTip;
		
		public function CacheDispaly()
		{
				
		}	

		public static function get iTooltip():IToolTip
		{
			if(_iTooltip==null){
				_iTooltip = new IToolTip();
			}
			return _iTooltip;
		}
		
		
		private static var seachIndex:int=0;
		public static function get cachePool():Object{
			return cache;
		}
		
	}
}