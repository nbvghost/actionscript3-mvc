package com.game.framework.ifaces {
	/**
	 *
	 *@author sixf
	 */
	
	import com.game.framework.display.LayerContainer;
	import com.game.framework.enum.MaskBackGroundType;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.geom.Rectangle;
	
	public interface IUILayer{
		
		/**
		 * 对象窗口的第一个
		 * @return 
		 * 
		 */
		function get firstFrontLayerContainer():LayerContainer;
		/**
		 * 对象窗口的第二个
		 * @return 
		 * 
		 */
		function get secondFrontLayerContainer():LayerContainer;
		/**
		 * 对象窗口的第三个
		 * @return 
		 * 
		 */
		function get centreLayerContainer():LayerContainer;
		/**
		 * 对象窗口的第四个
		 * @return 
		 * 
		 */
		function get backLayerContainer():LayerContainer;
		/**
		 * 边缘
		 * @return 
		 * 
		 */
		function getBorderRect():Rectangle;
		
		/**
		 * 设置遮罩
		 * @param container 把 addChild 动作也放在这里来处理了 ，所以也要传这个
		 * @param target 遮罩在 target 对象之后
		 * @param maskBackGroundType 遮罩的类型 MaskBackGroundType 成员
		 * 
		 */		
		function setMaskAfter(container:DisplayObjectContainer,target:DisplayObjectContainer,maskBackGroundType:int=MaskBackGroundType.DEFAUTL,closeBack:Function=null):InteractiveObject;
	}
}