package com.sanbeetle.interfaces
{
	import flash.events.Event;
	
	public interface IUIComponent 
	{
		function drawBorder (w:Number,h:Number):void;
		function get height ():Number;
		function get width ():Number;
		function set height (value:Number):void;
		function set width (value:Number):void;
		/**
		 * 组件的高度 
		 * @return 
		 * 
		 */
		function get trueHeight ():Number;
		/**
		 *  组件的宽度 
		 * @param value
		 * 
		 */
		function get trueWidth ():Number;		
		/**
		 * 更新 
		 * 
		 */
		function updateUI ():void;
		function dispose ():void;	
		
		
		
		
		/**
		 * 得到stage 
		 * @param event
		 * 
		 */
		function onStageHandler (event:Event):void;
		/**
		 * 跳到第二帧时，开始构建 样式、界面 
		 * 
		 */
		function createUI ():void;
		/**
		 * 设置高，宽
		 * @param w
		 * @param h
		 * 
		 */
		function setSize (w:Number,h:Number):void;
	}
}