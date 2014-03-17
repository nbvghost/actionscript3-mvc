package com.asvital.text
{
	public class TextPadding
	{
		private var _top:Number=0;
		private var _left:Number = 0;
		private var _right:Number = 0;
		private var _buttom:Number = 0;
		
		public function TextPadding(top:Number=0,left:Number=0,right:Number=0,buttom:Number=0)
		{
			this._top = top;
			this._left = left;
			this._right = right;
			this._buttom = buttom;
		}

		public function get buttom():Number
		{
			return _buttom;
		}

		public function set buttom(value:Number):void
		{
			_buttom = value;
		}

		public function get right():Number
		{
			return _right;
		}

		public function set right(value:Number):void
		{
			_right = value;
		}

		public function get left():Number
		{
			return _left;
		}

		public function set left(value:Number):void
		{
			_left = value;
		}

		public function get top():Number
		{
			return _top;
		}

		public function set top(value:Number):void
		{
			_top = value;
		}

	}
}