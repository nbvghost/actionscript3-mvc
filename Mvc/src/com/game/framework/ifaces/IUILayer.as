package com.game.framework.ifaces {
	/**
	 *
	 *@author sixf
	 */
	
	import com.game.framework.display.LayerContainer;
	
	import flash.geom.Rectangle;
	
	public interface IUILayer{
		
		function get firstFrontLayerContainer():LayerContainer;
		function get secondFrontLayerContainer():LayerContainer;
		function get centreLayerContainer():LayerContainer;
		function get backLayerContainer():LayerContainer;
		function getBorderRect():Rectangle;
	}
}