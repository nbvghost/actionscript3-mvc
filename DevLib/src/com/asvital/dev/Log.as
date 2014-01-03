package com.asvital.dev
{
	
	
	
	/**
	 * @author sixf
	 * 日期：2013-11-15 下午1:05:55 2013
	 * Administrator
	 */
	public class Log
	{
		
		private static var _callBack:Function;
		
		
		/**
		 * 错误
		 */
		public static const ERROR_LEVE:uint = 0x00000001;
		/**
		 * 信息
		 */
		public static const INFO_LEVE:uint = 0x00000002;
		/**
		 * 输出
		 */
		public static const OUT_LEVE:uint = 0x00000004;
		
		private static var leve:uint =OUT_LEVE;
		
		public static function setLeve(value:uint):void{
			leve = value;
		}
		public static function setCallBack(value:Function):void
		{
			_callBack = value;
		}		
		public function Log()
		{
			super();
			
			
		}
		public static function info(...ages):void{
			
			if((leve&INFO_LEVE) == INFO_LEVE )
			{
				ages.splice(0,0,"[信息]");				
				export.apply(null,ages);
			}
		}
		public static function error(...ages):void
		{			
			if((leve&ERROR_LEVE) == ERROR_LEVE )
			{
				ages.splice(0,0,"[错误]");	
				export.apply(null,ages);
			}
			
		}
		public static function out(...ages):void{
			
			if((leve&OUT_LEVE) == OUT_LEVE )
			{
				ages.splice(0,0,"[输出]");	
				export.apply(null,ages);
			}
		}
		private static function export(...ages):void{
			trace.apply(null,ages);			
			if(_callBack!=null){
				_callBack.apply(null,ages);
			}
		}		
	}
}