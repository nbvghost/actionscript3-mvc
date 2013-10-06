package com.game.framework.view
{
	
	/**
	 *
	 *@author sixf
	 */
	public class SpriteView extends CreateView 
	{
		public function SpriteView()
		{
			super(null);
		}	
		
		override public function get hasLoad():Boolean
		{
			
			return false;
		}
		
	}
}