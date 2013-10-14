package com.sanbeetle.core
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class UIComponent extends MovieClip
	{
		protected var trueWidth:int=0;
		protected var trueHeight:int=0;
		public function UIComponent()
		{
			trueWidth = this.width;
			trueHeight = this.height;		
			this.gotoAndStop(2);			
			this.scaleX = this.scaleY =1;	
			this.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
		}		
		private function onEnterFrameHandler(event:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
			
			if(this.stage==null){
				this.addEventListener(Event.ADDED_TO_STAGE,stageHaveHandler);
			}else{
				stageHaveHandler(null);
			}		
		}
		protected function updateUI():void{
			
		}
		public function dispose():void{
			
			
		}
		/**
		 *  
		 * @param event
		 * 
		 */
		private function stageHaveHandler(event:Event):void{			
			createUI();	
			onStageHandler(event);
		}		
		protected function onStageHandler(event:Event):void
		{
						
		}
		/**
		 * 跳到第二帧时，开始构建 样式、界面 
		 * 
		 */
		protected function createUI():void{
			
		}
		/**
		 * 设置高，宽
		 * @param w
		 * @param h
		 * 
		 */
		public function setSize(w:Number,h:Number):void{
			
		}
	}
}