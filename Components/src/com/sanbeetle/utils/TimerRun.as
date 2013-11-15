package com.sanbeetle.utils
{
	import com.sanbeetle.bases.BaseObject;
	import com.sanbeetle.interfaces.ITimerRun;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 *
	 *@author sixf
	 */
	public class TimerRun extends BaseObject
	{
		private var timerArr:Array;
		private static var timerrun:TimerRun;
		private var timer:Timer;
		public function TimerRun()
		{
			timerArr= new Array();
			
			timer = new Timer(component.TimerRunTime);
			timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
		}		
		private function onTimerHandler(event:TimerEvent):void
		{
			var lent:int =timerArr.length;
			for(var i:int=0;i<lent;i++){
				var item:ITimerRun = timerArr[i];
				if(item){
					item.timerRun(event);
				}				
			}
		}
		public function addRun(target:ITimerRun):void{
			timerArr.push(target);
			if(timerArr.length==1){
				timer.start();
			}
		}
		public function removeRun(target:ITimerRun):void{
			var index:int = timerArr.indexOf(target);
			timerArr.splice(index,1);			
			if(timerArr.length==0){
				timer.stop();
			}
		}
		public static function init():TimerRun{
			if(timerrun==null){
				timerrun = new TimerRun();
			}		
			return timerrun;
		}
		
	}
}