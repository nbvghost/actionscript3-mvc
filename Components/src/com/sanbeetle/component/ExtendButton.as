package com.sanbeetle.component
{
	import flash.display.DisplayObject;
	
	
	/**
	 * ITabButton 组件的按钮类
	 *@author sixf
	 */
	public class ExtendButton extends IButton
	{
		public function ExtendButton(up:DisplayObject=null, over:DisplayObject=null, down:DisplayObject=null)
		{
			super(up, over, down);	
			
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return trueHeight;
		}
		
		override public function set height(value:Number):void
		{
			// TODO Auto Generated method stub
			this.trueHeight = value;
			this.setSize(trueWidth,trueHeight);
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return trueWidth;
		}
		
		override public function set width(value:Number):void
		{
			// TODO Auto Generated method stub
			this.trueWidth = value;
			this.setSize(trueWidth,trueHeight);
		}	
		override protected function createUI():void
		{
			super.createUI();
			
			
		}
	}
}