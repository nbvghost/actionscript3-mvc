package com.sanbeetle.core
{
	import com.asvital.dev.Log;
	import com.sanbeetle.Component;
	import com.sanbeetle.interfaces.IStage;
	import com.sanbeetle.interfaces.ITimerRun;
	import com.sanbeetle.interfaces.IUIComponent;
	import com.sanbeetle.utils.TimerRun;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;


	/**
	 *
	 *@author sixf
	 */
	public class UIComponent extends ExtendMovieClip implements IUIComponent,IStage,ITimerRun
	{
		private var _trueWidth:Number = -1;
		private var _trueHeight:Number = -1;

		private var nw:Number=0;
		private var nh:Number=0;
		protected var component:Component;
		
		private var isInstage:Boolean =true;
		
		private var _toolTip:String=null;
		
		
		
		
		public function UIComponent ()
		{
			stop ();
			component = Component.component;
			//Component.component;
			if(component.contentContainer==null){
				Log.info("组件的容器不能为空，请使用 Component.component.initContentContainer(_contentContainer) 进行设制。");	
				
				if(stage!=null){
					component.initContentContainer(stage);
				}				
			}else{
				
				if(!component.contentContainer.isSetContainer){
					Log.info("容器没有添加到显示列表中。");
				}				
			}		
			

			_trueWidth = super.width;
			_trueHeight = super.height;

			while (this.numChildren>0)
			{
				this.removeChildAt (0);
			}

			var xx:int = this.x;
			var yy:int = this.y;

			this.x = Math.round(xx);
			this.y = Math.round(yy);

		
			
			this.scaleX = this.scaleY = 1;

			
			this.addEventListener (Event.ENTER_FRAME,onEnterFrameHandler);
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddStageHandler);			
		

		}
		//private var mousePoint:Point=new Point;
		public function timerRun(event:TimerEvent):void
		{
			
			if(stage){
				
				var op:Point = this.localToGlobal(new Point(mouseX,mouseY));
				
				CacheDispaly.iTooltip.x = op.x+16;
				CacheDispaly.iTooltip.y = op.y+16;
				CacheDispaly.iTooltip.textXML = _toolTip;
				stage.addChild(CacheDispaly.iTooltip);
				event.updateAfterEvent();
				TimerRun.init().removeRun(this);
			}
		}
		
		
		protected function onMouseRoolOutHandler(event:MouseEvent):void
		{
			
			TimerRun.init().removeRun(this);
			
			if(CacheDispaly.iTooltip.parent){
				CacheDispaly.iTooltip.parent.removeChild(CacheDispaly.iTooltip);
			}
		}
		
		protected function onMouseRoolOverHandler(event:MouseEvent):void
		{
			
			TimerRun.init().addRun(this);
		}
		
		/**
		 * 提示窗口 
		 */
		public function get toolTip():String
		{
			return _toolTip;
		}

		/**
		 * @private
		 */
		public function set toolTip(value:String):void
		{
			_toolTip = value;
			
			if(value!=null && value!="" && value!=" "){
				this.addEventListener(MouseEvent.ROLL_OVER,onMouseRoolOverHandler);
				this.addEventListener(MouseEvent.ROLL_OUT,onMouseRoolOutHandler);
				//this.addEventListener(MouseEvent.MOUSE_OUT,onMouseRoolOutHandler);
			}else{
				this.removeEventListener(MouseEvent.ROLL_OVER,onMouseRoolOverHandler);
				this.removeEventListener(MouseEvent.ROLL_OUT,onMouseRoolOutHandler);
				//this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseRoolOutHandler);
			}
		}

		override public function set x(value:Number):void
		{
			// TODO Auto Generated method stub
			super.x = Math.round(value);
		}
		
		override public function set y(value:Number):void
		{
			// TODO Auto Generated method stub
			super.y = Math.round(value);
		}
		
		
		private function onAddStageHandler(event:Event):void
		{
			
			
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveStageHandler);	
			
			this.onAddStage();
			
			//Log.out("add stage");
			
		}
		[Inspectable(defaultValue=1)]
		override public function get alpha():Number
		{
			// TODO Auto Generated method stub
			return super.alpha;
		}
		
		
		
		public function get inStage():Boolean
		{
			// TODO Auto Generated method stub
			return isInstage;
		}		
		
		override public function set alpha(value:Number):void
		{
			// TODO Auto Generated method stub
			super.alpha = value;
		}				
		private function onRemoveStageHandler(event:Event):void
		{		
			this.addEventListener(Event.ADDED_TO_STAGE,onAddStageHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStageHandler);
			this.onRemoveStage();
			this.dispose();				
			//Log.out("remove stage");
		}		
		protected function onRemoveStage():void{
			
		}
		protected function onAddStage():void{
			
		}
		protected function changeTrueSize(w:Number,h:Number):void{
			_trueWidth = Math.round(w);
			_trueHeight = Math.round(h);
		}
		
		
		public function drawBorder (w:Number,h:Number):void
		{
			if(nw!=w || nh!=h){
				nw =w;
				nh = h;
				if (component.debug)		
				{
					this.graphics.clear ();
					this.graphics.beginFill (0xFF00FF,0.5);
					this.graphics.drawRect (0,0,w,h);
					this.graphics.drawRect(1,1,w-2,h-2);
					this.graphics.endFill ();
				}else{
					this.graphics.clear ();
					this.graphics.beginFill (0xFF00FF,0);
					this.graphics.drawRect (0,0,w,h);
					this.graphics.drawRect(1,1,w-2,h-2);
					this.graphics.endFill ();
				}
			}
			

		}
		override public function get height ():Number
		{
			//if(trueHeight==-1){
			//trueHeight =super.width;
			//}
			//Console.out("components"+trueHeight);
			return _trueHeight;
		}
		override public function get width ():Number
		{
			//if(trueWidth==-1){
			//trueWidth =super.width;
			//}
			return _trueWidth;
		}
		override public function set height (value:Number):void
		{
			value= Math.round(value);
			
			if (_trueHeight!=value)
			{
				_trueHeight = value;
				this.updateUI ();
				//drawBorder(trueWidth,trueHeight);
			}

		}
		override public function set width (value:Number):void
		{
			value= Math.round(value);
			
			if (_trueWidth!=value)
			{
				_trueWidth = value;
				this.updateUI ();
				//drawBorder(trueWidth,trueHeight);
			}
		}
		/**
		 * 组件的高度 
		 * @return 
		 * 
		 */
		public function get trueHeight ():Number
		{
			return _trueHeight;
		}


		/*public function set trueHeight(value:int):void
		{
		_trueHeight = value;
		}*/
		/**
		 *  组件的宽度 
		 * @param value
		 * 
		 */
		public function get trueWidth ():Number
		{
			return _trueWidth;
		}
		/*public function set trueWidth(value:int):void
		{
		_trueWidth = value;
		}*/
		private function onEnterFrameHandler (event:Event):void
		{
			
			this.removeEventListener (Event.ENTER_FRAME,onEnterFrameHandler);
			

			if (this.stage == null)
			{
				this.addEventListener (Event.ADDED_TO_STAGE,stageHaveHandler);
			}
			else
			{
				stageHaveHandler (null);
			}
		}	
	
		/**
		 * 更新 
		 * 
		 */
		public function updateUI ():void
		{

		}
		public function dispose ():void
		{
			
		}		

		/**
		 *  
		 * @param event
		 * 
		 */
		private function stageHaveHandler (event:Event):void
		{
			this.removeEventListener (Event.ADDED_TO_STAGE,stageHaveHandler);
			createUI ();
			onStageHandler (event);
		}
		/**
		 * 得到stage 
		 * @param event
		 * 
		 */
		public function onStageHandler (event:Event):void
		{

		}
		/**
		 * 跳到第二帧时，开始构建 样式、界面 
		 * 
		 */
		public function createUI ():void
		{

		}
		/**
		 * 设置高，宽
		 * @param w
		 * @param h
		 * 
		 */
		public function setSize (w:Number,h:Number):void
		{
			_trueWidth = w;
			_trueHeight = h;

			updateUI ();

			drawBorder (trueWidth,trueHeight);


		}
	}
}