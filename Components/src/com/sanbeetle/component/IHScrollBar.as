package com.sanbeetle.component {
	
	import com.sanbeetle.core.ScrollBar;
	import com.sanbeetle.skin.IHScrollBarSkin_bar;
	import com.sanbeetle.skin.IHScrollBarSkin_bg;
	import com.sanbeetle.skin.IHScrollBarSkin_left;
	import com.sanbeetle.skin.IHScrollBarSkin_right;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	public class IHScrollBar extends ScrollBar {
		
		

		
		public function IHScrollBar() {
			s_left=new IHScrollBarSkin_left;
			s_right=new IHScrollBarSkin_right;
			s_bar=new IHScrollBarSkin_bar;
			bg=new IHScrollBarSkin_bg;
			
			s_bar.y=int(bg.height/2);
			s_bar.x =int(s_left.width);
		}
		
		override protected function createUI():void
		{
			super.createUI();
			
			
			bg.width = this.trueWidth;			
			s_right.x = this.trueWidth-s_right.width;
			
		}
		override protected function get isVScrollBarr():Boolean
		{
			// TODO Auto Generated method stub
			return false;
		}
		private var pin:int =10;
		override protected function onWheelDelta(delta:int):void
		{
			pin = Math.abs(delta)*(target.height/this.bg.height);
			if(delta>0){
				onLeftHandler(null);
			}else{
				onRightHandler(null);				
			}
		}	
		override protected function drawMask():void
		{
			
			maskmc.graphics.clear();
			maskmc.graphics.lineStyle(1,0xff0000);
			maskmc.graphics.beginFill(0xff0000);
			maskmc.graphics.drawRect(0,0,this.trueWidth,-target.height);
			maskmc.graphics.endFill();	
			
			target.x = this.x;
			target.y = this.y-target.height;			
			
			
			var kk:Number = maskmc.width/target.width;
			s_bar.width=0;
			var ss:Number = this.trueWidth-s_right.width-s_bar.width-s_left.width;			
			
			if(kk>=1){
				this.visible = false;
				disopose();
				kk=1;
			}else{
				this.visible =true;
			}
			var minHeight:Number = trueWidth/3;
			
			if((kk*ss)<minHeight){
				s_bar.width =minHeight;
			}else{
				s_bar.width =ss*kk;
			}
			
			//s_bar.width =ss*kk;
			//trace(this.width);
			
			target.mask = maskmc;	
			
			if(target.parent!=null){
				target.parent.setChildIndex(target,target.parent.numChildren-1);
			}
		}
		
		
		override protected function onBarDown(event:MouseEvent):void
		{
			s_bar.startDrag(false,new Rectangle(s_left.width,s_bar.y,this.trueWidth-s_right.width-s_bar.width-s_left.width,0));
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUphadnelr);
		}
		override protected function moveXY(fx:int,fy:int):void
		{
			target.x = stage.mouseX-fx;
			
			chackTargetXY();
		}
		override protected function chackTargetXY():void{
			if(target.x>=this.x){
				target.x =this.x;
				//trace("--");
			}
			if(target.x<=(this.x+(-(target.width-maskmc.width)))){
				target.x = this.x+(-(target.width-maskmc.width));
				//trace("--");
			}
		}
		protected function onMouseMoveHandler(event:MouseEvent):void
		{
			var tx:Number=(s_bar.x-s_left.width)/(this.trueWidth-s_right.width-s_bar.width-s_left.width)*100;
			tx=(Math.round(tx)/100);
			//target.x=(-target.width*tx)+this.x;
			target.x=this.x+(-(target.width-maskmc.width)*tx);
			//trace((s_bar.x-s_left.width)/(this.width-s_right.width-s_bar.width-s_left.width));
			event.updateAfterEvent();
		}
		
		protected function onMouseUphadnelr(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUphadnelr);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			s_bar.stopDrag();
		}
		override protected function upBarPoition():void
		{
			//s_bar.x=((target.x-this.x)/target.width);
			var p:Number=(-((target.x-this.x)/(target.width-maskmc.width)));
			
			var ww:Number =this.trueWidth-s_right.width-s_bar.width-s_left.width;
			s_bar.x = s_left.width+(p*ww);
		}
		override protected function onRightHandler(event:MouseEvent):void
		{
			//trace(event);		
			
			target.x -=pin;
			this.chackTargetXY();
			//onMouseMoveHandler(null);
			upBarPoition();
		}
		
		override public function setSize(w:Number, h:Number):void
		{			
			super.setSize(w, h);
			
			bg.width = this.trueWidth;			
			s_right.x = this.trueWidth-s_right.width;
		}	
		override protected function onLeftHandler(event:MouseEvent):void
		{
			//trace(event);
			target.x +=pin;
			this.chackTargetXY();
			upBarPoition();
		}
		
	}
	
}
