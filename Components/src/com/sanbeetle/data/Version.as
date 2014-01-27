package com.sanbeetle.data
{
	public class Version
	{
		private var _name:String="内存优化";
		private var _code:uint=45;
		
		public function Version()
		{
			
		}

		public function get code():uint
		{
			return _code;
		}

		public function get name():String
		{
			return _name;
		}
		public function toString():String{
			return "版本:"+_name+",ver:"+_code;
		}

	}
}