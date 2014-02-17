package com.sanbeetle.data
{
	public class Version
	{
		private var _name:String="BUG修复";
		private var _code:uint=50;
				
		public function Version()
		{
			
		}

		/**
		 * 版本号 
		 * @return 
		 * 
		 */
		public function get code():uint
		{
			return _code;
		}

		/**
		 * 版本名称 
		 * @return 
		 * 
		 */
		public function get name():String
		{
			return _name;
		}
		public function toString():String{
			return "版本:"+_name+",ver:"+_code;
		}

	}
}