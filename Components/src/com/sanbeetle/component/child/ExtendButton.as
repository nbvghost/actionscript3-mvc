package com.sanbeetle.component.child
{
	import com.sanbeetle.component.IButton;
	
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

		/*
		override public function get height():Number
		{
			
			return trueHeight;
		}
		
		override public function set height(value:Number):void
		{
			
			this.trueHeight = value;
		
			this.updateUI();
		}
		
		override public function get width():Number
		{
			
			return trueWidth;
		}
		
		override public function set width(value:Number):void
		{
			
			this.trueWidth = value;
			
			this.updateUI();
		}	*/
		/*override protected function createUI():void
		{
			super.createUI();
			
			
		}*/
	}
}