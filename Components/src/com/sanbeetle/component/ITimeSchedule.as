package com.sanbeetle.component
{

	import com.sanbeetle.core.FixedUIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.ITimeScheduleSkin;
	import com.sanbeetle.utils.Utils;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	[Event(name = "time_complete",type = "com.sanbeetle.events.ControlEvent")]
	/**
	 * var date:Date = new Date();
			date.setHours(0,0,0,0);
			begin(date);
			
			date = new Date();
			date.setHours(1,0,0,0);
			to(date);
			
			date = new Date();
			date.setHours(0,1,0,0);
			to(date);<br/>
	 */
	public class ITimeSchedule extends FixedUIComponent
	{

		private var skin:ITimeScheduleSkin;
		
		private var toDate:Number;
		private var beginDate:Number;
		private var currentDate:Number = 0;
		private var timer:Timer;
		private var dateTxt:Date;
		public function ITimeSchedule()
		{
			skin =new ITimeScheduleSkin();
			timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,onTimerHandler);
			
			dateTxt = new Date();
			
			
		}
		/**
		 * 暂停 
		 * 运行中的，将停止，停止中的将运行
		 */
		public function pause():void
		{
			if (this.timer.running)
			{
				this.timer.stop();
			}
			else
			{
				this.timer.start();
			}
		}
		
		override protected function createUI():void
		{
					
			
			this.addChild(skin);			
		
		}		
		private function onTimerHandler(event:TimerEvent):void
		{
			//trace(toDate,beginDate);
			skin.jdt_mc.width = (1 - (currentDate / (toDate - beginDate))) * skin.bbl_mc.width;
			//trace((toDate-beginDate),currentDate);
			currentDate = currentDate + 1000;
			dateTxt.setTime(toDate-(currentDate));

			skin.sj_txt.text = Utils.NumberPrefix(dateTxt.getHours()) + ":" + Utils.NumberPrefix(dateTxt.getMinutes()) + ":" + Utils.NumberPrefix(dateTxt.getSeconds());

			//trace(dateTxt.getHours(),dateTxt.getMinutes(),dateTxt.getSeconds());
			if (dateTxt.getHours() == 0 && dateTxt.getMinutes() == 0 && dateTxt.getSeconds() == 0)
			{
				timer.stop();
				this.dispatchEvent(new ControlEvent(ControlEvent.TIME_COMPLETE));
			}

		}

		/**
		 * 目标时间
		
		 * 
		 */
		public function to(date:Date):void
		{
			toDate = date.getTime();	
			dateTxt.setTime(toDate-(currentDate));
			skin.sj_txt.text = Utils.NumberPrefix(dateTxt.getHours()) + ":" + Utils.NumberPrefix(dateTxt.getMinutes()) + ":" + Utils.NumberPrefix(dateTxt.getSeconds());
			timer.start();
		}
		/**
		 * 开始时间
		 * @param date
		 * 
		 */
		public function begin(date:Date):void
		{			
			skin.jdt_mc.scaleX = 1;
			beginDate = date.getTime();		
			
			
		}
	}

}