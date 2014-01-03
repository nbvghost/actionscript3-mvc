package com.sanbeetle.component
{
	import com.sanbeetle.core.TextBox;
	
	
	/**
	 * 显示文本，输入框 ，多行文本，html文本
	 *@author sixf
	 */
	public class ILabel extends TextBox
	{
		
		public function ILabel()
		{
			super();
			this.paddingTop = 5;
			this.paddingLeft = 2;
			this.paddingBottom =2;
			this.paddingRight = 2;			
			
			
		}	
		[Inspectable(defaultValue=2)]
		override public function get paddingLeft():Number
		{
			// TODO Auto Generated method stub
			return super.paddingLeft;
		}
		[Inspectable(defaultValue=5)]
		override public function get paddingTop():Number
		{
			// TODO Auto Generated method stub
			return super.paddingTop;
		}
		
	
	}
	
}