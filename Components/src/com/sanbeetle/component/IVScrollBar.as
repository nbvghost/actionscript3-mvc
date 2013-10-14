package com.sanbeetle.component {
	
	import com.sanbeetle.core.ScrollBar;
	import com.sanbeetle.skin.IVScrollBarSkin_bar;
	import com.sanbeetle.skin.IVScrollBarSkin_bg;
	import com.sanbeetle.skin.IVScrollBarSkin_buttom;
	import com.sanbeetle.skin.IVScrollBarSkin_top;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	public class IVScrollBar extends ScrollBar {
		
		
		public function IVScrollBar() {
			s_left=new IVScrollBarSkin_top;
			s_right=new IVScrollBarSkin_buttom;
			s_bar=new IVScrollBarSkin_bar;
			bg=new IVScrollBarSkin_bg;
		}		
		override protected function createUI():void
		{			
			super.createUI();	
			
			s_bar.y=int(s_left.height);
			s_bar.x = int(bg.width/2);
			
			bg.height = this.trueHeight;			
			s_right.y = this.trueHeight-s_right.height;		
			
		}	
		override public function setSize(w:Number, h:Number):void
		{			
			super.setSize(w, h);
			
			bg.height = this.trueHeight;			
			s_right.y = this.trueHeight-s_right.height;		
		}	
		override protected function get isVScrollBarr():Boolean
		{
			// TODO Auto Generated method stub
			return true;
		}
		
		
		override protected function onBarDown(event:MouseEvent):void
		{
			s_bar.startDrag(false,new Rectangle(s_left.height/2,s_left.height,0,bg.height-s_right.height-s_bar.height-s_left.height));
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUphadnelr);
		}
		
		override protected function drawMask():void
		{			
			maskmc.graphics.clear();
			maskmc.graphics.lineStyle(1,0xff0000);
			maskmc.graphics.beginFill(0xff0000);
			maskmc.graphics.drawRect(0,0,-target.width,trueHeight);
			maskmc.graphics.endFill();	
			
			target.x = this.x-target.width;
			target.y = this.y;			
			
			var kk:Number = maskmc.height/target.height;
			
			
			s_bar.height=0;
			var ss:Number = trueHeight-s_right.height-s_bar.height-s_left.height;
			//trace("trueHeight:"+trueHeight,s_right.height,s_bar.height,s_left.height,ss);
			
			if(kk>=1){
				this.visible = false;
				disopose();
				kk=1;
			}else{
				this.visible =true;
			}
			
			var minHeight:Number =trueHeight/3;
			if((kk*ss)<minHeight){
				s_bar.height =minHeight;
			}else{
				s_bar.height =ss*kk;
			}	
			
			//trace("target.height:"+target.height,s_bar.height,(trueHeight),kk,ss);
			
			
			target.mask = maskmc;
			
			if(target.parent!=null){
				target.parent.setChildIndex(target,target.parent.numChildren-1);
			}
		}
		
		
		protected function onMouseMoveHandler(event:MouseEvent):void
		{
			var tx:Number=(s_bar.y-s_left.height)/(trueHeight-s_right.height-s_bar.height-s_left.height)*100;
			tx=(Math.round(tx)/100);
			//target.x=(-target.width*tx)+this.x;
			target.y=this.y+(-(target.height-maskmc.height)*tx);
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
			var p:Number=(-((target.y-this.y)/(target.height-maskmc.height)));
			
			var ww:Number =trueHeight-s_right.height-s_bar.height-s_left.height;
			s_bar.y = s_left.height+(p*ww);
		}
		override protected function onRightHandler(event:MouseEvent):void
		{
			//trace(event);			
			target.y -=pin;
			
			chackTargetXY();
			upBarPoition();
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
		
		override protected function moveXY(fx:int,fy:int):void
		{
			target.y = stage.mouseY-fy;
		
			chackTargetXY();
		}		
		override protected function chackTargetXY():void{
			if(target.y>=this.y){
				target.y =this.y;				
			}
			if(target.y<=(this.y+(-(target.height-maskmc.height)))){
				target.y = this.y+(-(target.height-maskmc.height));				
			}
		}
		override protected function onLeftHandler(event:MouseEvent):void
		{			
			target.y +=pin;
			
			chackTargetXY();
			upBarPoition();
		}
		
		
	}
	
}
