package com.game.framework.display {
	import com.game.framework.ifaces.IRander;
	
	import flash.events.Event;
	
	/**
	 * 视觉组件的基类
	 *@author sixf
	 */
	public class UIComponent extends BaseSprite implements IRander {
		public function UIComponent() {
			super();
			
		}
		
		public function enterFrame(e:Event):void {
			// TODO Auto Generated method stub
			
		}
		
		public function reSize(e:Event):void {
			// TODO Auto Generated method stub
			
		}
		
		
	}
}