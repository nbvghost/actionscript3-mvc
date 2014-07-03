package com.sanbeetle.data
{
	public class Version
	{
		private var _name:String="Popular";
		private var _code:uint=81;
		private var _decoration:String = "雷达图文字可以改颜色:IUILoader Bug 修复";
				
		public function Version()
		{
			
		}

		public function get decoration():String
		{
			return _decoration;
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