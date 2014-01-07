package com.sanbeetle.component.child {
	
	import com.sanbeetle.component.ILabel;
	import com.sanbeetle.interfaces.ITimerRun;
	
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	
	
	public class ITimeScheduleSkin extends MovieClip implements ITimerRun {
		
		
		public var sj_txt:ILabel;
	
		public var timerRunFunc:Function;
		
		public var progressBar:ProgressBarSkin;
		
		public function timerRun(event:TimerEvent):void
		{
			if(timerRunFunc!=null){
				timerRunFunc(event);
			}			
		}
		
		
		public function ITimeScheduleSkin() {
			progressBar = new ProgressBarSkin();		
			
			this.addChild(progressBar);
			
			
			progressBar.y =5;			
			
			sj_txt =new ILabel();
			sj_txt.height = 17.75;
			sj_txt.width = 50;
			//sj_txt.autoSize = TextFieldAutoSize.LEFT;
			sj_txt.text = "--:--:--";
			sj_txt.fontSize ="11";
			//sj_txt.leading =0;
			//sj_txt.height =10;
			//sj_txt.border =true;
			//sj_txt.wordWrap =false;
			sj_txt.multiline = false;
			sj_txt.multiline =false;
			sj_txt.x = 69.2;			
			sj_txt.y = 0;
			//sj_txt.border =true;
			//sj_txt.height = bbl_mc.height;
			addChild(sj_txt);
		}
		public function onlyText(value:Boolean):void{
			
			if(value){
				if(progressBar.parent){
					progressBar.parent.removeChild(progressBar);
				}
				//progressBar.visible = false;
				
				sj_txt.x =0;
			}else{
				//progressBar.visible = true;
				this.addChild(progressBar);				
				sj_txt.x = 69.2;
			}
				
			
			
		}
	}
	
}
