package com.game.framework.ifaces {
	/**
	 *
	 *@author sixf
	 */
	
	import com.game.framework.display.AppStage;
	
	import flash.geom.Rectangle;
	
	/**
	 * UIManager 接口，对 UIManager 的访问
	 * @author Administrator
	 *
	 */
	public interface IUIManager {		
		function getLayerRect():Rectangle;
		
		function get appStage():AppStage;		
		function get uiLayer():IUILayer;
		
	}
}