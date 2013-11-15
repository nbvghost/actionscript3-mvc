package com.sanbeetle.component
{
	
	import com.sanbeetle.component.child.ITimeScheduleSkin;
	import com.sanbeetle.component.child.ProgressBarSkin;
	import com.sanbeetle.core.FixedUIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.ITimerRun;
	import com.sanbeetle.utils.TimerRun;
	import com.sanbeetle.utils.Utils;
	
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
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
	public class ITimeSchedule extends FixedUIComponent implements ITimerRun
	{
		
		private var initDate:Date;
		private var skin:ITimeScheduleSkin;
		
		private var totalTime:Number=0;
		
		private var currentTime:Number = 0;
		private var timer:TimerRun;
		private var dateTxt:Date;
		private var _timeTextColor:String="0xffffff";
		private var _onlyText:Boolean = false;
		private var _hideText:Boolean = false;
		
		private var runTime:Number = 0;
		private var isRuning:Boolean = false;
		
		
		private var _border:int = 0;		
		private var _borderColor:String ="0x000000";
		private var _borderAlpha:Number = 1;
		
		private var _slipColor:String="0x234E02";
		private var _backgroundColor:String="0xDDE6D6";
		
		public function ITimeSchedule()
		{
			
			
			initDate=new Date();
			
			skin =new ITimeScheduleSkin();
			skin.sj_txt.color = _timeTextColor;
			
			
			
			timer =TimerRun.init();
			timer.addRun(this);
			
			dateTxt = new Date();
			
			//skin.jdt_mc.scaleX = 0;
			
			/*
			var ite:ProgressBarSkin = new ProgressBarSkin();
			ite.setSize();
			ite.slipColor = 0xff0000;
			ite.backgroundColor = 0x0f00f0;
			ite.currentValue = 0.5;
			this.addChild(ite);*/
			
		}			
		[Inspectable(defaultValue=false)]
		public function get hideText():Boolean
		{
			return _hideText;
		}

		public function set hideText(value:Boolean):void
		{
			_hideText = value;
			if(_hideText==true){
				skin.sj_txt.visible =false;
			}else{
				skin.sj_txt.visible =true;
			}
			
		}

		[Inspectable(defaultValue="0xDDE6D6")]
		public function get backgroundColor():String
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:String):void
		{
			_backgroundColor = value;
			skin.progressBar.backgroundColor = uint(_backgroundColor);
		}
		[Inspectable(defaultValue="0x234E02")]
		public function get slipColor():String
		{
			return _slipColor;
		}

		public function set slipColor(value:String):void
		{
			_slipColor = value;
			skin.progressBar.slipColor = uint(_slipColor);
		}
		[Inspectable(defaultValue=1)]
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}

		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
			skin.progressBar.borderAlpha = uint(_borderAlpha);
		}
		[Inspectable(defaultValue="0x000000")]
		public function get borderColor():String
		{
			return _borderColor;
		}

		public function set borderColor(value:String):void
		{
			_borderColor = value;
			skin.progressBar.borderColor = uint(_borderColor);
		}
		[Inspectable(defaultValue=0)]
		public function get border():int
		{
			return _border;
		}

		public function set border(value:int):void
		{
			_border = value;
			skin.progressBar.border = uint(_border);
		}

		[Inspectable(defaultValue =false)]	
		public function get onlyText():Boolean
		{
			return _onlyText;
		}
		
		public function set onlyText(value:Boolean):void
		{
			_onlyText = value;			
			skin.onlyText(value);
		}
		
		[Inspectable(defaultValue ="0xffffff")]	
		public function get timeTextColor():String
		{
			return _timeTextColor;
		}
		
		public function set timeTextColor(value:String):void
		{
			_timeTextColor = value;
			skin.sj_txt.color = _timeTextColor;
		}
		
		/**
		 * 暂停 
		 * 运行中的，将停止，停止中的将运行
		 */
		public function pause():void
		{
			if (this.isRuning)
			{
				isRuning = false;				
				timer.removeRun(this);
			}
			else
			{
				isRuning = true;				
				timer.addRun(this);
			}
		}
		
		override protected function createUI():void
		{
			
			
			this.addChild(skin);			
			
		}		
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			timer.removeRun(this);
		}
		
		public function timerRun(event:TimerEvent):void
		{			
			
			currentTime = currentTime - (getTimer()-runTime);
			
			if (currentTime<=0)
			{
				currentTime=0;
				setTimerTxt();
				//skin.jdt_mc.scaleX = 0;
				//this.removeEventListener(Event.ENTER_FRAME,onTimerHandler);
				timer.removeRun(this);
				this.isRuning = false;
				this.dispatchEvent(new ControlEvent(ControlEvent.TIME_COMPLETE));
			}else{
				setTimerTxt();
				
			}
			runTime = getTimer();
		}
		public function start():void{
			isRuning = true;			
			runTime = getTimer();
			//this.addEventListener(Event.ENTER_FRAME,onTimerHandler);
			timer.addRun(this);
			
		}
		private function setTimerTxt():void{
			skin.progressBar.currentValue =(currentTime /totalTime);
			dateTxt.setTime(currentTime);
			//Console.out("components"+dateTxt);
			//dateTxt.setTime(dateTxt.getTime()+(totalTime-(currentTime)));
			//dateTxt.setTime(dateTxt.getTime()+currentTime);
			//Console.out("components"+dateTxt.getMinutes()+1,dateTxt.getSeconds()+1,dateTxt.getMilliseconds()+1);
			
			skin.sj_txt.text = Utils.TimeDataPrefix(int(currentTime/1000/60/60)) + ":" + Utils.TimeDataPrefix(dateTxt.getMinutes()) + ":" + Utils.TimeDataPrefix(dateTxt.getSeconds());
			
		}
		/**
		 * 目标时间，要完成倒计时的总时间。
		 * 如：一个小时时间长度。date
		 * 通过 Date.setHours(); 来设置
		 * @see Date#setHours()
		 */
		public function setTotalDate(total:Number):void
		{
			//Console.out("components"+"components"+"total:"+total);
			//initDate.setHours(date.getHours(),date.getMinutes(),date.getSeconds(),date.getMilliseconds());
			
			//var cu:Number = initDate.getTime();	
			
			//initDate.setHours(0,0,0,0);			
			totalTime = total;	
			//Console.out("components"+"components"+"总时间长度为："+totalTime+"毫秒");			
		}
		/**
		 * 开始倒计时的时间。
		 * @param date
		 * 1000000000
		 */
		public function begin(begin:Number=-1):void
		{			
			//Console.out("components"+"components"+"begin:"+begin);
			if(begin==-1){
				currentTime =totalTime;
			}else{
				//initDate.setHours(date.getHours(),date.getMinutes(),date.getSeconds(),date.getMilliseconds());	
				
				//var cu:Number = initDate.getTime();			
				currentTime = begin;
				
				//initDate.setHours(0,0,0,0);
				//currentTime = cu-initDate.getTime();	
			}			
			//Console.out("components"+"components"+"开始倒计时的时间长度为："+currentTime+"毫秒");	
			if(currentTime>totalTime){
				
				this.isRuning = false;
				this.dispatchEvent(new ControlEvent(ControlEvent.TIME_COMPLETE));				
				return;
			}
			
			//skin.jdt_mc.width = (1 - (currentTime /totalTime)) * skin.bbl_mc.width;			
			
			setTimerTxt();		
			
		}
	}
	
}