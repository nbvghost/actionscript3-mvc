package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IStarSkin;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	
	public class IStar extends UIComponent {
		
		private var _isShowCurrent:Boolean =false;
		//1.6394121944904327 0.39457953069359064
		private var _total:Number=1.5;
		private var _current:Number=0.5;
		
		private var arrr:Array = new Array();
		
		public function IStar() {
			// constructor code
		}
		[Inspectable(defaultValue =false)]	
		public function get isShowCurrent():Boolean
		{
			return _isShowCurrent;
		}
		
		public function set isShowCurrent(value:Boolean):void
		{
			_isShowCurrent = value;
			createStar();
		}
		
		[Inspectable(enumeration = "0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10",defaultValue =0.5)]
		public function get current():Number
		{
			return _current;
		}
		
		public function set current(value:Number):void
		{
			_current = value;
			createStar();
		}
		[Inspectable(enumeration = "0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10",defaultValue =1.5)]
		public function get total():Number
		{
			return _total;
		}
		
		public function set total(value:Number):void
		{
			_total = value;
			createStar();
		}
		
		override protected function createUI():void
		{
			//trace(57%10);
			
			var timetr:Timer = new Timer(2000);
			timetr.addEventListener(TimerEvent.TIMER,onsdfs);
			
			//timetr.start();
			createStar();
			
		}
		
		protected function onsdfs(event:TimerEvent):void
		{
			_total = int(Math.random()*10);
			_current = int(Math.random()*_total);
			
			trace(_current,_total);
			createStar();
		}
		private function createStar():void{
			var i:int=0;
			for(i=0;i<arrr.length;i++){
				//IStarSkin(arrr[i])
				this.removeChild(arrr[i]);
			}
			arrr.splice(0,arrr.length);
			var skin:IStarSkin;
			var hi:int =0;	
			
			if(_isShowCurrent==false){
				for(i=0;i<int(_total);i++){					
					
					skin = new IStarSkin();
					skin.x = skin.width*i;
					skin.gotoAndStop(1);
					this.addChild(skin);
					arrr.push(skin);
							
					
				}
				if((_total%1)>0){
					skin = new IStarSkin();
					skin.x = skin.width*i;
					skin.gotoAndStop(4);
					this.addChild(skin);
					arrr.push(skin);
				}
				
				return;
			}
			
			for(i=0;i<int(_total);i++){
				
				
				if(int(_current)>i){
					skin = new IStarSkin();
					skin.x = skin.width*i;
					skin.gotoAndStop(1);
					this.addChild(skin);
					arrr.push(skin);
					hi =i;
				}else{
					skin = new IStarSkin();
					skin.x = skin.width*i;
					skin.gotoAndStop(3);
					this.addChild(skin);
					arrr.push(skin);
				}
				
			}
			
			
			if((_total%1)>0 && (_total%1)<1){				
				
				
				skin = new IStarSkin();
				skin.x = skin.width*i;
				if(_current>_total){
					skin.gotoAndStop(4);
				}else{
					skin.gotoAndStop(5);
				}
				
				this.addChild(skin);
				arrr.push(skin);
			}
			
			if(_current>0 && _current<1){
				skin = new IStarSkin();
				skin.x = skin.width*0;
				skin.gotoAndStop(4);
				this.addChild(skin);
				arrr.push(skin);
			}else{
				
				if((_current%1)>0){
					skin = new IStarSkin();
					if(_current>_total){
						skin.x = skin.width*0;
					}else{
						skin.x = skin.width*(hi+1);
					}					
					skin.gotoAndStop(4);
					this.addChild(skin);
					arrr.push(skin);
				}
				
			}		
			
			
		}
		
	}
	
}
