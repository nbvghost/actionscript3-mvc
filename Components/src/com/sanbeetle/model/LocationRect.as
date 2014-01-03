package com.sanbeetle.model
{
	
	/**
	 *
	 *@author sixf
	 */
	public class LocationRect 
	{
		private var _left:int=0;
		private var _right:int=0;
		private var _buttom:int=0;
		private var _top:int=0;
		public function LocationRect(top:int=0,right:int=0,buttom:int=0,left:int=0)
		{
			this._buttom = buttom;
			this._left = left;
			this._right = right;
			this._top = top;
		}
		[Inspectable()]
		public function get top():int
		{
			return _top;
		}

		public function set top(value:int):void
		{
			_top = value;
		}
		[Inspectable()]
		public function get buttom():int
		{
			return _buttom;
		}

		public function set buttom(value:int):void
		{
			_buttom = value;
		}
		[Inspectable()]
		public function get right():int
		{
			return _right;
		}

		public function set right(value:int):void
		{
			_right = value;
		}
		[Inspectable()]
		public function get left():int
		{
			return _left;
		}

		public function set left(value:int):void
		{
			_left = value;
		}
		
		public function toString():String{
		
			return "[top:"+top+",right:"+right+",buttom:"+buttom+",left:"+left+"]";
		}

	}
}