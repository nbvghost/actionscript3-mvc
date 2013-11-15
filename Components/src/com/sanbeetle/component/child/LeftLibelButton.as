package com.sanbeetle.component.child
{
	import flash.display.DisplayObject;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class LeftLibelButton extends ExtendButton
	{
		public function LeftLibelButton(upw:DisplayObject=null, overw:DisplayObject=null, downw:DisplayObject=null)
		{
			super(upw, overw, downw);			
			//this.btnlabel.border =true;
		}
		
		override public function get align():String
		{
			// TODO Auto Generated method stub
			return TextFormatAlign.LEFT;
		}
		
		override public function get autoSize():String
		{
			// TODO Auto Generated method stub
			return TextFieldAutoSize.LEFT;	
		}
		
		override protected function createUI():void
		{			
			super.createUI();
			this.btnlabel.width = this.trueWidth;
			this.btnlabel.height = this.trueHeight;
			btnlabel.x = 8;
		}
		
		override protected function updateUI():void
		{
			// TODO Auto Generated method stub
			super.updateUI();
			btnlabel.x = 8;
		}
		
		
	}
}