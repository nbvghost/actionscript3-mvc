package com.sanbeetle.model
{
	
	/**
	 *
	 *@author sixf
	 */
	public class AMark
	{
		public static const URL:String="url";
		public static const EVENT:String="event";
		
		private var _target:String;
		private var _type:String=URL;
		
		private var _data:Object;
		
		
		public function AMark()
		{
			
		}		

		/**
		 * a 标签自定义的属性， 数据 
		 */
		public function get data():Object
		{
			return _data;
		}

		/**
		 * @private
		 */
		public function set data(value:Object):void
		{
			_data = value;
		}

		/**
		 *  public static const URL:String="url";
		 * 	public static const EVENT:String="event";
		 */
		public function get type():String
		{
			return _type;
		}

		/**
		 * @private
		 */
		public function set type(value:String):void
		{
			_type = value;
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