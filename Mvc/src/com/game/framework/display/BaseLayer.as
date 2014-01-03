package com.game.framework.display
{
	import com.game.framework.ifaces.IRander;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class BaseLayer implements IRander
	{

		private var _graphics:Graphics;
	
		protected var container:UIComponent;
		
		
		/**
		 *  
		 * @param container 将父容器引用 进行，相对于 BaseLayer 生成 新的容器  container 属性。
		 * 
		 */
		public function BaseLayer(parentContainer:DisplayObjectContainer)
		{
			super();	
			
			container=new UIComponent();
			
			_graphics = container.graphics;
			
			parentContainer.addChild(container);		
		}
		
		public function timerRun(event:TimerEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		public function get graphics():Graphics
		{
			return _graphics;
		}

		public function enterFrame(e:Event):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function reSize(e:Event):void
		{
			// TODO Auto Generated method stub
			
		}
		
	}
}