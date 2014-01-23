package com.game.framework.display {
	import com.game.framework.ifaces.IRander;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	/**
	 * 视觉组件的基类
	 *@author sixf
	 */
	public class UIComponent extends BaseSprite implements IRander {
		
		public static var appStage:AppStage;
		
		public function UIComponent() {
			super();
			
			
		}
		public static function setAppStage(_appStage:AppStage):void{
			appStage = _appStage;
		}
		
		public function enterFrame(e:Event):void {
			// TODO Auto Generated method stub			
		}
		
		public function reSize(e:Event):void {
			// TODO Auto Generated method stub
			
		}
		
		public function timerRun(event:TimerEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		
	}
}