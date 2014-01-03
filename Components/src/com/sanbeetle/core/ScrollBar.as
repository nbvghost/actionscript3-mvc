package com.sanbeetle.core
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
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
		
		protected var maskmc:Shape;
		protected var target:DisplayObjectContainer;		
		protected var _source:Object="target";
		
		
		
		
		private var _contentHeight:Number=0;
		private var _contentWidth:Number=0;
		
		private var len:int = 0;
		private var time:Number = 100;
		private var sd:Number = time;
		private var fp:Number =0;
		private var p:Number = 0;
		protected var timer:int;
		
		public function ScrollBar()
		{		
			super();	
			maskmc = new Shape();
			
			//maskmc.cacheAsBitmap =true;
			//targetMouse.cacheAsBitmap=true;
			
		}	
		
		
		public function get contentWidth():Number
		{
			if(this.target){
				return this.target.width;
			}else{
				return 0;
			}
			
		}
		
		public function get contentHeight():Number
		{
			if(this.target){
				return this.target.height;
			}else{
				return 0;
			}
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
		
		
		override public function createUI():void
		{			
			super.createUI();			
			source = this._source;
			
			
			
			this.addChild(bg);
			this.addChild(s_left);
			this.addChild(s_right);
			this.addChild(s_bar);
			
			s_left.buttonMode =true;		
			s_right.buttonMode = true;			
			s_bar.buttonMode = true;				
			
			s_right.addEventListener(MouseEvent.CLICK,onRightHandler);
			s_left.addEventListener(MouseEvent.CLICK,onLeftHandler);	
			bg.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			
			s_bar.addEventListener(MouseEvent.MOUSE_DOWN,onBarDownHandler);			
			
			createTarget();
		}		
		
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			if(isVScrollBarr){
				
				scrollBarPosition((bg.mouseY-s_left.height)/(bg.height-s_left.height-s_right.height));
			}else{				
				scrollBarPosition((bg.mouseX-s_left.width)/(bg.width-s_left.width-s_right.width));			
				
			}
			
			//Log.out(bg.mouseX,bg.mouseY);
		}
		
		protected function moveXY(firstX:int,firstY:int):void{
			
		}	
		private function createTarget():void{
			
			//Console.out("components"+"components"+"dsfdsfdsf:"+target);
			if(target!=null){
				target.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
				this.addEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
				target.addEventListener(MouseEvent.MOUSE_DOWN,onTargetDownHandler);		
				
				addChild(maskmc);				
				
				drawMask();	
			}		
			
		}
		public function upDisplayList():void{
			disopose();
			//Console.out("components"+"components"+"更新目标！");
			createTarget();
			updateUI();			
			
		}		
		protected function disopose():void{
			if(target!=null){
				target.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
				target.removeEventListener(MouseEvent.MOUSE_DOWN,onTargetDownHandler);
			}			
			this.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
			
		}
		protected function scrollBarPosition(value:Number):void{
			//Log.out(value);
		}
		private function tweenTo(value:Number):void{
			//Console.out("components"+Math.round(value),Math.round((fp + len)));
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
			//target.mouseChildren = false;
			timer = getTimer();
			point.x = target.mouseX;
			point.y = target.mouseY;
			
			len=0;
			time = 100;
			sd = time;
			
			this.addEventListener(Event.ENTER_FRAME,onTimerHandelr);
			
			if(stage){
				stage.addEventListener(MouseEvent.MOUSE_UP,onTargetTimerUPHadnler);
			}
			
			
		}
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();		
			
			this.removeEventListener(Event.ENTER_FRAME,onTimerHandelr);
			//stageLink.removeEventListener(MouseEvent.MOUSE_UP,onTargetTimerUPHadnler);	
			
			this.removeEventListener(Event.ENTER_FRAME,onTweenEFHandler);
			this.removeEventListener(MouseEvent.MOUSE_WHEEL,onMouseWheelHandler);
			
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
			
			if(stage==null){
				return;
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_UP,onTargetTimerUPHadnler);			
			
			//target.mouseChildren = true;
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
			//Console.out("components"+len);			
			if(len!=0){
				
				
			}	
			this.addEventListener(Event.ENTER_FRAME,onTweenEFHandler);
			
			this.removeEventListener(Event.ENTER_FRAME,onTimerHandelr);
			
			
			point.x = 0;
			point.y = 0;
			timer=0;
		}
		
		protected function onTweenEFHandler(event:Event):void
		{
			//Console.out("components"+len);
			
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
			
		}
		private var point:Point=new Point();
		private function onMouseWheelHandler(event:MouseEvent):void
		{
			//Console.out("components"+event.delta);
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
			this.width=w;
			this.height=h;			
		}
		public function set source(value:Object):void
		{			
			this._source = value;
			
			if(value is String){
				target = this.parent.getChildByName(String(value)) as DisplayObjectContainer;
			}else if(value is DisplayObject){
				//Console.out("components"+"components"+"a");
				target = value as DisplayObjectContainer;
			}else if(value is BitmapData){
				var te:Sprite =new Sprite();
				te.addChild(new Bitmap(value as BitmapData));
				target = te;
			}else if(value is Object){
				
				target = this.parent.getChildByName(String(value.target)) as DisplayObjectContainer;
			}	
			if(target==null){
				
				return;
			}
			
			//Log.out(target);			
			this.upDisplayList();
			
		}
		
	}
}