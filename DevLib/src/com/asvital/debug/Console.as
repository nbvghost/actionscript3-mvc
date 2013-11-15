package com.asvital.debug
{
	import flash.trace.Trace;
	
	public class Console extends Trace
	{
		
		public static function getOutCallBack():Function
		{
			return _outCallBack;
		}
		
		public static function setOutCallBack(value:Function):void
		{
			_outCallBack = value;
		}
		
		private static var _outCallBack:Function;
		public function Console()
		{
			super();
		}
		public static function out(...ages):void{
			trace.apply(null,ages);
			if(_outCallBack!=null){
				_outCallBack.apply(null,ages);
			}
		
		}
	}
}