package com.sanbeetle.component.child
{
	import com.sanbeetle.component.IButton;
	import com.sanbeetle.core.TextBox;
	
	import flash.display.DisplayObject;
	
	
	/**
	 * ITabButton 组件的按钮类
	 *@author sixf
	 */
	public class ExtendButton extends IButton
	{
		private var _index:int;
		
		public function ExtendButton(up:DisplayObject=null, over:DisplayObject=null, down:DisplayObject=null)
		{
			super(up, over, down);	
			
		}
		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}
		public function get buttonLabel():TextBox
		{
			return btnlabel;
		}
	}
}