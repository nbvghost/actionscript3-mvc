package com.sanbeetle.core
{
	import com.sanbeetle.skin.IHScrollBarSkin_bar;
	import com.sanbeetle.skin.IHScrollBarSkin_bg;
	import com.sanbeetle.skin.IHScrollBarSkin_left;
	import com.sanbeetle.skin.IHScrollBarSkin_right;
	import com.sanbeetle.skin.IVScrollBarSkin_bar;
	import com.sanbeetle.skin.IVScrollBarSkin_bg;
	import com.sanbeetle.skin.IVScrollBarSkin_buttom;
	import com.sanbeetle.skin.IVScrollBarSkin_top;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	/**
	 *
	 *@author sixf
	 */
	public class ScrollBar extends UIComponent
	{
		protected var s_left:MovieClip;
		public var s_bar:MovieClip;
		public var s_right:MovieClip;
		public var bg:MovieClip;
		
		protected var maskmc:Shape=new Shape();
		protected var target:InteractiveObject;
		
		
		protected var _source:DisplayObject;
		
		
		private var len:int = 0;
		private var time:Number = 100;
		private var sd:Number = time;
		private var fp:Number =0;
		private var p:Number = 0;
		protected var timer:int;
		
		public function ScrollBar()
		{		
			super();
			
			/*var a1:IVScrollBarSkin_top;
			var a2:IVScrollBarSkin_buttom;
			var a3:IVScrollBarSkin_bar;
			var a4:IVScrollBarSkin_bg;
			
			var a5:IHScrollBarSkin_left;
			var a6:IHScrollBarSkin_right;
			var a7:IHScrollBarSkin_bar;
			var a8:IHScrollBarSkin_bg;*/
		}
		private function onBarDownHandler(event:MouseEvent):void
		{
			this.removeEventListener(Event.ENTER_FRAME,onTweenEFHandler);
			onBarDown(event);
		}
		protected function onBarDown(event:MouseEvent):void{
			
		}
		protected function onRightHandler(event:MouseEvent):void
		{
			
		}
		protected function onLeftHandler(event:MouseEvent):void
		{
			
		}
		protected function upBarPoition():void{
			
		}
		override protected function createUI():void
		{			
			super.createUI();			
			
			this.addChild(bg);
			this.addChild(s_left);
			this.addChild(s_right);
			this.addChild(s_bar);
			
			s_left.buttonMode =true;		
			s_right.buttonMode = true;			
			s_bar.buttonMode = true;				
			
			s_right.addEventListener(MouseEvent.CLICK,onRightHandler);
			s_left.addEventListener(MouseEvent.CLICK,onLeftHandler);			
			
			s_bar.addEventListener(MouseEvent.MOUSE_DOWN,onBarDownHandler);			
			
			createTarget();
		}		
		
		override protected function onStageHandler(event:Event):void
		{			
			stage.addEventListener(MouseEvent.MOUSE_OVER,onOverHadneler);
		}
		
		protected function moveXY(firstX:int,firstY:int):void{
			
		}
		
		private function onOverHadneler(event:MouseEvent):void
		{
			//trace(event);
			if(event.target == target){
				//stage.stageFocusRect = true;
				//stage.focus = target;
			}
		}
		private function createTarget():void{
			target = _source as InteractiveObject;
			//trace("dsfdsfdsf:"+target);
			if(target!=null){
				target.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
				this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
				target.addEventListener(MouseEvent.MOUSE_DOWN,onTargetDownHandler);				
				drawMask();				
				this.addChild(maskmc);
			}		
			
		}
		public function upDisplayList():void{
			disopose();
			//trace("更新目标！");
			createTarget();	
		}		
		protected function disopose():void{
			if(target!=null){
				target.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
				target.removeEventListener(MouseEvent.MOUSE_DOWN,onTargetDownHandler);
			}			
			this.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
			
			
		}
		private function tweenTo(value:Number):void{
			//trace(Math.round(value),Math.round((fp + len)));
			if (Math.round(value) == Math.round((fp + len))){
				this.removeEventListener(Event.ENTER_FRAME,onTweenEFHandler);
			}			
			if(isVScrollBarr){
				
				this.target.y=value;
			}else{				
				this.target.x=value;					
				
			}
			chackTargetXY();
			upBarPoition();
		}
		protected function chackTargetXY():void{
			
		}
		private function onTargetDownHandler(event:MouseEvent):void
		{
			timer = getTimer();
			point.x = target.mouseX;
			point.y = target.mouseY;
			
			len=0;
			time = 100;
			sd = time;
			
			this.addEventListener(Event.ENTER_FRAME,onTimerHandelr);
			stage.addEventListener(MouseEvent.MOUSE_UP,onTargetTimerUPHadnler);
			
		}
		/**
		 *是否垂直滚动条
		 *  
		 * @return 
		 * 
		 */
		protected function get isVScrollBarr():Boolean{
			return false;
		}
		private function onTargetTimerUPHadnler(event:MouseEvent):void
		{
			//point.x = target.mouseX;
			//point.y = target.mouseY;
			
			var t:int = getTimer()-timer;
			
			if(isVScrollBarr){
				len = (target.mouseY-point.y);
				fp =target.y;
			}else{
				len = (target.mouseX-point.x);
				fp =target.x;
			}
			//trace(len);			
			if(len!=0){
				
				
			}	
			this.addEventListener(Event.ENTER_FRAME,onTweenEFHandler);
			
			this.removeEventListener(Event.ENTER_FRAME,onTimerHandelr);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onTargetTimerUPHadnler);
			point.x = 0;
			point.y = 0;
			timer=0;
		}
		
		protected function onTweenEFHandler(event:Event):void
		{
			//trace(len);
			
			time = time * 0.8;
			p = 1 - (time / sd);				
			tweenTo(fp + (p * len));
		}
		
		private function onTimerHandelr(event:Event):void
		{		
			if(Math.abs(target.mouseX-point.x)>1 || Math.abs(target.mouseY-point.y)>1){
				
				moveXY(point.x,point.y);
				upBarPoition();
			}	
			
			if((getTimer()-timer)>200){
				//trace(":");
				//moveXY(point.x,point.y);
			}else{
				
			}
		}
		private var point:Point=new Point();
		private function onMouseWheelHandler(event:MouseEvent):void
		{
			//trace(event.delta);
			onWheelDelta(event.delta);
		}
		protected function onWheelDelta(delta:int):void{
			
		}
		protected function drawMask():void{
			
			
		}
		[Inspectable(defaultValue ="target" )]
		public function get source():Object
		{
			return _source;
		}
		override public function setSize(w:Number,h:Number):void{
			this.trueWidth=w;
			this.trueHeight=h;
			
		}
		public function set source(value:Object):void
		{			
			if(value is String){
				_source = this.parent.getChildByName(String(value));
			}else if(value is BitmapData){
				_source = new Bitmap(value as BitmapData);
			}else if(value is DisplayObject){
				_source = value as DisplayObject;
			}		
			
			this.upDisplayList();
			
		}
		
	}
}