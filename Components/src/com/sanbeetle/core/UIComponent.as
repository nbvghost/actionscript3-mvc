package com.sanbeetle.core
{
	import com.sanbeetle.Component;

	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.events.Event;


	/**
	 *
	 *@author sixf
	 */
	public class UIComponent extends MovieClip
	{
		private var _trueWidth:int = -1;
		private var _trueHeight:int = -1;

		protected var component:Component;


		public function UIComponent ()
		{
			stop ();
			component = Component.component;


			_trueWidth = super.width;
			_trueHeight = super.height;

			while (this.numChildren>0)
			{
				this.removeChildAt (0);
			}

			var xx:int = this.x;
			var yy:int = this.y;

			this.x = xx;
			this.y = yy;

			this.gotoAndStop (2);
			this.scaleX = this.scaleY = 1;

			//Console.out("components"+this.x,this.y);

			drawBorder (trueWidth,trueHeight);


			this.addEventListener (Event.ENTER_FRAME,onEnterFrameHandler);

		}
		protected function drawBorder (w:int,h:int):void
		{

			this.graphics.clear ();
			this.graphics.beginFill (0x0ff000,0);
			if (component.debug)
			{
				this.graphics.lineStyle (1,0x000ff0,0.05,false, LineScaleMode.NONE);
			}
			else
			{
				this.graphics.lineStyle (1,0x000ff0,0,false, LineScaleMode.NONE);
			}
			this.graphics.drawRect (0,0,w,h);
			this.graphics.endFill ();

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
			if (_trueHeight!=value)
			{
				_trueHeight = value;
				this.updateUI ();
				//drawBorder(trueWidth,trueHeight);
			}

		}
		override public function set width (value:Number):void
		{
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
		public function get trueHeight ():int
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
		public function get trueWidth ():int
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
		protected function updateUI ():void
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
		protected function onStageHandler (event:Event):void
		{

		}
		/**
		 * 跳到第二帧时，开始构建 样式、界面 
		 * 
		 */
		protected function createUI ():void
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