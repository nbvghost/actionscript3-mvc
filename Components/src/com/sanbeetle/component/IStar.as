package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.skin.IStarSkin;
	
	
	public class IStar extends UIComponent {
		
		private var _isShowCurrent:Boolean =false;
		//1.6394121944904327 0.39457953069359064
		private var _total:Number=1.5;
		private var _current:Number=0.5;
		
		private var arrr:Array = new Array();
		
		private var _startOrientation:String="left";
		
		public static const left_orientation:String="left";
		public static const right_orientation:String="right";
		
		public function IStar() {
			
		}
		[Inspectable(enumeration = "left,right",defaultValue ="left")]
		public function get startOrientation():String
		{
			return _startOrientation;
		}
		
		public function set startOrientation(value:String):void
		{
			_startOrientation = value;
			createStar();
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
		
		[Inspectable(enumeration = "-1,0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10",defaultValue =0.5)]
		public function get current():Number
		{
			return _current;
		}
		
		public function set current(value:Number):void
		{
			_current = value;
			createStar();
		}
		[Inspectable(enumeration = "-1,0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5.5,6,6.5,7,7.5,8,8.5,9,9.5,10",defaultValue =1.5)]
		public function get total():Number
		{
			return _total;
		}
		
		public function set total(value:Number):void
		{
			_total = value;
			createStar();
		}
		
		override public function createUI():void
		{
			//Console.out("components"+57%10);
			
			
			//timetr.addEventListener(TimerEvent.TIMER,onsdfs);
			
			//timetr.start();
			createStar();
			
			if(skin){
				
				this.drawBorder(stCount*skin.width,skin.height);
			}
			
		}	
		private function changeX(xx:Number):Number{
			if(_startOrientation==IStar.left_orientation){
				
				return xx;
			}else{
				return -xx;
			}
		}
		
		override protected function onAddStage():void
		{
			// TODO Auto Generated method stub
			super.onAddStage();
			if(skin){
				
				this.drawBorder(stCount*skin.width,skin.height);
			}
		}
		
		/*protected function onsdfs(event:TimerEvent):void
		{
		_total = int(Math.random()*10);
		_current = int(Math.random()*_total);
		
		Console.out("components"+_current,_total);
		createStar();
		}*/
		private var stCount:int =0;
		private var skin:IStarSkin;
		private function createStar():void{
			
			var i:int=0;
			for(i=0;i<arrr.length;i++){
				//IStarSkin(arrr[i])
				this.removeChild(arrr[i]);
			}
			
			arrr.splice(0,arrr.length);
			
			if((_current)<0 || (_total)<=0){
				this.graphics.clear();
				this.graphics.beginFill(0x333333);
				this.graphics.drawRect(4,this.trueHeight/2,this.trueWidth-4,1);
				this.graphics.endFill();
				
				this.drawBorder(this.width,this.height);
				return;
			}else{
				this.graphics.clear();
			}
			
			
			var hi:int =0;	
			stCount =0;
			
			if(_isShowCurrent==false){
				for(i=0;i<int(_total);i++){					
					
					skin = new IStarSkin();
					skin.x = changeX((skin.width+1)*i);
					skin.gotoAndStop(1);
					this.addChild(skin);
					arrr.push(skin);
					stCount++;
					
				}
				if((_total%1)>0){
					skin = new IStarSkin();
					skin.x = changeX((skin.width+1)*i);
					skin.gotoAndStop(4);
					this.addChild(skin);
					arrr.push(skin);
					stCount++;
				}
				this.drawBorder(this.width,this.height);
				return;
			}
			
			for(i=0;i<int(_total);i++){
				
				
				if(int(_current)>i){
					skin = new IStarSkin();
					skin.x = changeX((skin.width+1)*i);
					skin.gotoAndStop(1);
					this.addChild(skin);
					arrr.push(skin);
					stCount++;
					hi =i;
				}else{
					skin = new IStarSkin();
					skin.x =changeX((skin.width+1)*i);
					skin.gotoAndStop(3);
					this.addChild(skin);
					arrr.push(skin);
					stCount++;
				}
				
			}
			
			
			if((_total%1)>0 && (_total%1)<1){				
				
				
				skin = new IStarSkin();
				skin.x = changeX((skin.width+1)*i);
				if(_current>_total){
					skin.gotoAndStop(4);
				}else{
					skin.gotoAndStop(5);
				}
				
				this.addChild(skin);
				stCount++;
				arrr.push(skin);
			}
			
			if(_current>0 && _current<1){
				skin = new IStarSkin();
				skin.x = changeX(skin.width*0);
				skin.gotoAndStop(4);
				this.addChild(skin);
				stCount++;
				arrr.push(skin);
			}else{
				
				if((_current%1)>0){
					skin = new IStarSkin();
					if(_current>_total){
						skin.x = changeX(skin.width*0);
					}else{
						skin.x = changeX((skin.width+1)*(hi+1));
					}					
					skin.gotoAndStop(4);
					this.addChild(skin);
					stCount++;
					arrr.push(skin);
				}
				
			}		
			if(skin){
			
				this.drawBorder(stCount*skin.width,skin.height);
			}
			
		}
		
	}
	
}
