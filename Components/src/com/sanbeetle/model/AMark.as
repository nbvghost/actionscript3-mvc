package com.sanbeetle.model
{
	import flash.net.URLVariables;
	
	/**
	 *
	 *@author sixf
	 */
	public class AMark
	{
			
		private var _target:String;		
		private var _parameters:URLVariables;		
		
		public function AMark()
		{
			
		}		

		/**
		 * a 标签自定义的属性， 数据 
		 */
		public function get parameters():URLVariables
		{
			return _parameters;
		}
		/**
		 * @private
		 */
		public function set parameters(value:URLVariables):void
		{
			_parameters = value;
		}
		/**
		 * 如果为 URL ,target = url 地址
		 *  如果为 event , target = 事件类型
		 */
		public function get target():String
		{
			return _target;
		}

		/**
		 * @private
		 */
		public function set target(value:String):void
		{
			_target = value;
		}

	}
}