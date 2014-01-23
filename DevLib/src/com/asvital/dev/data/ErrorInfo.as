package com.asvital.dev.data
{
	import flash.system.Capabilities;
	import flash.system.System;

	/**
	 *  错误信息对象
	 * @author sixf
	 * 
	 */
	public class ErrorInfo
	{
		private var _time:Number = 0;
		private var _txt:String ="";
		
		private var _type:String="";
		private var _id:String="";
		private var _name:String ="";
		private var _data:Object ={};
		
		private var _freeMemory:Number = 0;
		private var _privateMemory:Number=0;
		private var _totalMemory:Number=0;
		private var _totalMemoryNumber:Number = 0;
		
		private var _capabilities:String="";
		
		public function ErrorInfo()
		{
			_freeMemory = System.freeMemory;
			_privateMemory = System.privateMemory;
			_totalMemory = System.totalMemory;
			_totalMemoryNumber = System.totalMemoryNumber;			
			_capabilities=JSON.stringify(Capabilities);			
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get txt():String
		{
			return _txt;
		}

		public function set txt(value:String):void
		{
			_txt = value;
		}

		public function get time():Number
		{
			return new Date().getTime();
		}		

		public function get freeMemory():Number
		{
			return _freeMemory;
		}

		public function get privateMemory():Number
		{
			return _privateMemory;
		}

		public function get totalMemory():Number
		{
			return _totalMemory;
		}

		public function get totalMemoryNumber():Number
		{
			return _totalMemoryNumber;
		}

		public function get capabilities():String
		{
			return _capabilities;
		}

	}
}