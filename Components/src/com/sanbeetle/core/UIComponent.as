package com.sanbeetle.core
{
	import com.asvital.dev.Log;
	import com.sanbeetle.Component;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.ITimerRun;
	import com.sanbeetle.interfaces.IUIComponent;
	import com.sanbeetle.utils.TimerRun;
	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	[Event(name="component_create_ui", type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 *
	 *@author sixf
	 */
	public class UIComponent extends ExtendMovieClip implements IUIComponent,ITimerRun
	{
		private var _trueWidth:Number = -1;
		private var _trueHeight:Number = -1;
		
		private var nw:Number=0;
		private var nh:Number=0;
		protected var component:Component;
		
		private var isInstage:Boolean =true;
		
		private var _toolTip:String=null;
		
		private var linkRoot:DisplayObject;
		
		private var _linkStage:Stage;
		
		private var _glowFilter:Object={};
		
		public function UIComponent ()
		{
			stop ();
			component = Component.component;
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
			var r:Number = rotation;
			rotation = 0;
			_trueWidth = super.width;
			_trueHeight = super.height;
			rotation = r;
			
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
		/**
		 * stage 的一个引用 ，完全等于  stage,不同的是， 在显示对象从舞台移除时， linkStage 还是不会为空，使用这个保证了，对象移除，无法移除 stage 的事件。可以 配合   onAddStage 和  onRemoveStage
		 * @see #onRemoveStage()
		 * @see #onAddStage()
		 * @see flash.display.Stage
		 * @return
		 * 
		 */
		protected function get linkStage():Stage
		{
			return _linkStage;
		}

		[Inspectable(defaultValue="true")]
		override public function get visible():Boolean
		{
			// TODO Auto Generated method stub
			return super.visible;
		}
		
		
		[Inspectable(type="Object",defaultValue="enable:false,color:0x000000,alpha:1,blurX:6,blurY:6,strength:2,quality:1,inner:false,knockout:false")]
		public function get glowFilter():Object
		{
			return _glowFilter;
		}
		/**
		 *  
		 * 如果组件支持更新（对组件重绘、设置数据等，大部分是重绘，这个将影响组件的工作效率）
		 */		
		public function upDisplayList():void
		{
			
		}		
		public function set glowFilter(value:Object):void
		{
			_glowFilter = value;
			
			if(_glowFilter.enable==true){
				filters = [new GlowFilter(_glowFilter.color,_glowFilter.alpha,_glowFilter.blurX,_glowFilter.blurY,_glowFilter.strength,_glowFilter.quality,_glowFilter.inner,_glowFilter.knockout)];
			}else{
				this.filters = [];
			}
			
		}

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
			}else{
				this.removeEventListener(MouseEvent.ROLL_OVER,onMouseRoolOverHandler);
				this.removeEventListener(MouseEvent.ROLL_OUT,onMouseRoolOutHandler);
			}
		}
		
		override public function set x(value:Number):void
		{
			super.x = Math.round(value);
		}
		
		override public function set y(value:Number):void
		{
			super.y = Math.round(value);
		}
		
		
		private function onAddStageHandler(event:Event):void
		{
			isInstage = true;
			
			_linkStage = stage;
			
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddStageHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveStageHandler);	
			
			this.onAddStage();			
			
		}
		
		private function onViewDisposeHandler(event:Event):void
		{
			//trace(linkRoot,event.currentTarget,event.currentTarget);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddStageHandler);		
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStageHandler);			
			
			TimerRun.init().removeRun(this);
			
			this.removeChildren();
			
			if(this.parent){
				this.parent.removeChild(this);
			}	
			
			this.dispose();
			
			component =null;
			if(linkRoot){				
				linkRoot.removeEventListener(ControlEvent.VIEW_DISPOSE,onViewDisposeHandler);
			}
			linkRoot=null;
			this.graphics.clear();
			
			_linkStage =null;
			
			//trace("Dispose View Component!");	
		}
		
		[Inspectable(defaultValue=1)]
		override public function get alpha():Number
		{
			return super.alpha;
		}
		
		public function get haveStage():Boolean
		{
			return isInstage;
		}
		
		public function setStage(value:Boolean):void
		{
			isInstage = value;
		}
		
		override public function set alpha(value:Number):void
		{
			super.alpha = value;
		}				
		private function onRemoveStageHandler(event:Event):void
		{		
			isInstage = false;
		
			this.addEventListener(Event.ADDED_TO_STAGE,onAddStageHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoveStageHandler);
			this.onRemoveStage();	
			
			
		}		
		/**
		 * 当组件从舞台移除时触发
		 * 
		 */		
		protected function onRemoveStage():void{
			
		}
		/**
		 * 当组件从舞台添加时触发
		 * 
		 */		
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
			return _trueHeight;
		}
		override public function get width ():Number
		{
			return _trueWidth;
		}
		override public function set height (value:Number):void
		{
			value= Math.round(value);
			
			if (_trueHeight!=value)
			{
				_trueHeight = value;
				this.updateUI ();
			}
			
		}
		override public function set width (value:Number):void
		{
			value= Math.round(value);
			
			if (_trueWidth!=value)
			{
				_trueWidth = value;
				this.updateUI ();
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
		
		
		
		/**
		 *  组件的宽度 
		 * @param value
		 * 
		 */
		public function get trueWidth ():Number
		{
			return _trueWidth;
		}
		
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
		protected function updateUI ():void
		{
			
		}
		/**
		 * 该方法内存释放，只关注自身内存的释放代码，无须为其它对象做内存释放，其它对象也有自己的释放方法，凡 继承了 UIComponent 就是这样的。 
		 * 
		 */		
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
			linkRoot= this.root;
			this.removeEventListener (Event.ADDED_TO_STAGE,stageHaveHandler);
			createUI ();
			this.dispatchEvent(new ControlEvent(ControlEvent.COMPONENT_CREATE_UI));
			
			onStageHandler (event);
			
			if(linkRoot){
				linkRoot.addEventListener(ControlEvent.VIEW_DISPOSE,onViewDisposeHandler);
			}			
		}
		/**
		 * 得到stage 
		 * @param event
		 * 
		 */
		private function onStageHandler (event:Event):void
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