package com.sanbeetle.model
{
	import com.sanbeetle.data.ListData;
	
	import flash.display.DisplayObject;

	public class ItemRendererTarget
	{
		private var _listData:ListData;		
		private var _target:DisplayObject;
		
		public function ItemRendererTarget()
		{
			
		}

		public function get target():DisplayObject
		{
			return _target;
		}

		public function set target(value:DisplayObject):void
		{
			_target = value;
		}

		public function get listData():ListData
		{
			return _listData;
		}

		public function set listData(value:ListData):void
		{
			_listData = value;
		}

	}
}