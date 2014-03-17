package com.sanbeetle.component
{
	
	import com.sanbeetle.core.ScrollBar;
	import com.sanbeetle.skin.IVScrollBarSkin_bar;
	import com.sanbeetle.skin.IVScrollBarSkin_bg;
	import com.sanbeetle.skin.IVScrollBarSkin_buttom;
	import com.sanbeetle.skin.IVScrollBarSkin_top;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	public class IVScrollBar extends ScrollBar
	{
		
		private var vscrollbarposition:Number = 0;
		
		private var pin:int = 10;
		
		public function IVScrollBar ()
		{
			
			s_left = new IVScrollBarSkin_top  ;
			s_right = new IVScrollBarSkin_buttom  ;
			s_bar = new IVScrollBarSkin_bar  ;
			bg = new IVScrollBarSkin_bg  ;
			
		}
		override public function createUI ():void
		{
			super.createUI ();
			
			s_bar.y = int(s_left.height);
			s_bar.x = 4;
			
			bg.height = this.trueHeight;
			s_right.y = this.trueHeight - s_right.height;
			
			this.setVScrollBarPosition (this.vscrollbarposition);
			
		}
		
		override public function updateUI ():void
		{
			
			bg.height = this.trueHeight;
			s_right.y = this.trueHeight - s_right.height;
			
			this.drawBorder (this.trueWidth,this.trueHeight);
			
		}
		
		
		override public function setSize (w:Number, h:Number):void
		{
			super.setSize (w, h);
			
			bg.height = this.trueHeight;
			s_right.y = this.trueHeight - s_right.height;
		}
		override protected function get isVScrollBarr ():Boolean
		{
			// TODO Auto Generated method stub
			return true;
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			if (stage)
			{
				stage.removeEventListener (MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
				stage.removeEventListener (MouseEvent.MOUSE_UP,onMouseUphadnelr);
			}
		}
		
		
		override protected function onBarDown (event:MouseEvent):void
		{
			s_bar.startDrag (false,new Rectangle(s_bar.x,s_left.height,0,bg.height-s_right.height-s_bar.height-s_left.height));
			
			
			if (stage)
			{
				stage.addEventListener (MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
				stage.addEventListener (MouseEvent.MOUSE_UP,onMouseUphadnelr);
			}
		}
		
		
		protected function onMouseMoveHandler (event:MouseEvent):void
		{
			if (target)
			{
				var tx:Number=(s_bar.y-s_left.height)/(trueHeight-s_right.height-s_bar.height-s_left.height)*100;
				tx=(Math.round(tx)/100);
				//target.x=(-target.width*tx)+this.x;
				target.y=this.y+(-(target.height-maskmc.height)*tx);
				//Log.out(target.y);
				//Console.out("components"+(s_bar.x-s_left.width)/(this.width-s_right.width-s_bar.width-s_left.width));
				event.updateAfterEvent ();
			}
		}
		
		protected function onMouseUphadnelr (event:MouseEvent):void
		{
			stage.removeEventListener (MouseEvent.MOUSE_UP,onMouseUphadnelr);
			stage.removeEventListener (MouseEvent.MOUSE_MOVE,onMouseMoveHandler);
			s_bar.stopDrag ();
		}
		
		override protected function upBarPoition ():void
		{
			//s_bar.x=((target.x-this.x)/target.width);
			var p:Number=(-((target.y-this.y)/(target.height-maskmc.height)));
			
			var ww:Number = trueHeight - s_right.height - s_bar.height - s_left.height;
			s_bar.y = s_left.height + (p * ww);
		}
		override protected function onRightHandler (event:MouseEvent):void
		{
			//Console.out("components"+event);
			target.y -=  pin;
			
			chackTargetXY ();
			upBarPoition ();
		}
		override protected function onWheelDelta (delta:int):void
		{
		
			pin = Math.abs(delta)*(this.bg.height*stepNum);
			if (delta>0)
			{
				onLeftHandler (null);
			}
			else
			{
				onRightHandler (null);
			}
			//trace(pin);
		}
		
		override protected function scrollBarPosition (value:Number):void
		{
			setVScrollBarPosition (value);
			//Log.out(value);
		}
		
		/**
		 * 设置滚动位置 
		 * @param value
		 * 
		 */
		override public function setVScrollBarPosition (values:Number):void
		{
			vscrollbarposition = values;
			if (vscrollbarposition<0)
			{
				vscrollbarposition = 0;
			}
			if (vscrollbarposition>1)
			{
				vscrollbarposition = 1;
			}
			if (target)
			{
				var tx:Number=(s_bar.y-s_left.height)/(trueHeight-s_right.height-s_bar.height-s_left.height)*100;
				tx = (vscrollbarposition / 100);
				
				target.y=Math.round(this.y+(-(target.height-maskmc.height)*vscrollbarposition));
				
				//s_bar.y = ((trueHeight-s_right.height-s_bar.height)*value)+s_left.height-s_right.height;
				s_bar.y = (s_left.height+((trueHeight-s_bar.height-s_right.height-s_left.height)*vscrollbarposition))+s_left.height-s_right.height;
				
			}
		}
		
		override public function getScrollBarPosition():Number
		{
			
			return (s_bar.y-s_left.height)/(trueHeight-s_right.height-s_bar.height-s_left.height);
		}
		
		
		override protected function moveXY (fx:int,fy:int):void
		{
			
			if (target && stage!=null)
			{
				target.y = stage.mouseY - fy;
			}
			
			
			chackTargetXY ();
			
		}
		/**
		 * 
		 * 
		 */		
		override protected function drawMask ():void
		{
			
			maskmc.graphics.clear ();
			maskmc.graphics.beginFill (0xff0000,0);
			maskmc.graphics.drawRect (0,0,-(target.width+Math.abs(scrollBeginPoint.x)),trueHeight+scrollBeginPoint.y);
			maskmc.graphics.endFill ();
			
			rectBackGround.graphics.clear();
			rectBackGround.graphics.beginFill(0xff0000,0);
			rectBackGround.graphics.drawRect(0,0,target.width,trueHeight);
			rectBackGround.graphics.endFill();
			
			target.y = this.y;
			
			var kk:Number = maskmc.height / target.height;
			
			
			s_bar.height = 0;
			var ss:Number = trueHeight - s_right.height - s_bar.height - s_left.height;
			if (kk>=1)
			{
				this.visible = false;
				target.x = this.x - target.width;
				disopose ();
				kk = 1;
			}
			else
			{
				this.visible = true;
				target.x = this.x - target.width;
				target.mask = maskmc;
			}		
			var minHeight:Number = trueHeight / 3;
			if ((kk*ss)<minHeight)
			{
				
				s_bar.height = minHeight;
				
			}
			else
			{
				s_bar.height =ss*kk;
			}
			
			
			pin = this.trueHeight;
			
			
			rectBackGround.x = target.x;
			rectBackGround.y = target.y;			
			
		}
		override protected function chackTargetXY ():void
		{
			if (target.y >= this.y)
			{
				target.y = this.y;
			}
			if (target.y<=(this.y+(-(target.height-maskmc.height))))
			{
				target.y = this.y+(-(target.height-maskmc.height));
			}
		}
		override protected function onLeftHandler (event:MouseEvent):void
		{
			target.y +=  pin;
			
			chackTargetXY ();
			upBarPoition ();
		}
		
		
	}
	
}