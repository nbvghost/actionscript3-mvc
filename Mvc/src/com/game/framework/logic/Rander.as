package com.game.framework.logic
{
	import com.game.framework.data.ConfigData;
	import com.game.framework.error.OperateError;
	import com.game.framework.ifaces.IRander;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author sixf
	 * 日期：2013-11-18 下午6:07:29 2013
	 * Administrator
	 */
	public class Rander //implements IRander
	{
		private static var ef_List:Vector.<IRander>=new Vector.<IRander>();
		private static var resize_list:Vector.<IRander>=new Vector.<IRander>();
		private static var timer_list:Vector.<IRander>=new Vector.<IRander>();
		
		private static var timer:Timer;
		

		
		public function Rander()
		{
						
			throw new OperateError("不能实例化，请使用静态访问！");
		}
		
		public static function timerRun(event:TimerEvent):void
		{
			for each(var rander:IRander in timer_list) {
				rander.timerRun(event);
			}
			
		}		
		public static  function enterFrame(e:Event):void
		{
			for each(var rander:IRander in ef_List) {
				rander.enterFrame(e);
			}
			
		}
		
		public static function reSize(e:Event):void
		{
			
			for each(var rander:IRander in resize_list) {
				rander.reSize(e);
			}		
		}
		
		public static function removeTimerRun(rander:IRander):void {
			var index:int = timer_list.indexOf(rander);
			if(index==-1){
				return;
			}
			timer_list.splice(index, 1);	
			
			if(timer_list.length<=0){
				timer.stop();
			}
		}
		public static function removeEnterFrame(rander:IRander):void {
			var index:int = ef_List.indexOf(rander);
			if(index==-1){
				return;
			}
			ef_List.splice(index, 1);
			
			
		}
		public static function removeReSize(rander:IRander):void {
			var index:int = resize_list.indexOf(rander);
			if(index==-1){
				return;
			}
			resize_list.splice(index, 1);			
		}
		public static function addEnterFrame(rander:IRander):void {
			ef_List.push(rander);			
		}		
		public static function addReSize(rander:IRander):void {
			resize_list.push(rander);
			
		}
		public static function addTimerRun(rander:IRander):void{
			timer_list.push(rander);
			if(timer==null){
				timer = new Timer(ConfigData.getDelayTime());
				timer.addEventListener(TimerEvent.TIMER,timerRun);
			}
			
			if(timer_list.length>0){
				timer.start();
			}
		}
	}
}