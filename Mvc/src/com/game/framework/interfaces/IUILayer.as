package com.game.framework.interfaces
{
	/**
	 *
	 *@author sixf
	 */
	import com.game.framework.display.UIComponent;
	
	import flash.geom.Rectangle;

	public interface IUILayer
	{
		function get getTopLayer():UIComponent;		
		function get getMediaLayer():IUILayerLayout;		
		function get getBackgroundLayer():UIComponent;
		function getBorderRect():Rectangle;			
	}
}