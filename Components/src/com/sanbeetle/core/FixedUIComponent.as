package com.sanbeetle.core
{
	
	/**
	 *
	 *@author sixf
	 */
	public class FixedUIComponent extends UIComponent
	{
		public function FixedUIComponent()
		{
			super();
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return this.trueHeight;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return this.trueWidth;
		}
		
	}
}