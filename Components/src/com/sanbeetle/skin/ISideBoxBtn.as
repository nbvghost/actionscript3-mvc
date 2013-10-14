package com.sanbeetle.skin
{

	import flash.display.MovieClip;
	import flash.events.MouseEvent;


	public class ISideBoxBtn extends MovieClip
	{


		public function ISideBoxBtn()
		{
			this.stop();
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseEventHandler);
		}

		protected function onMouseEventHandler(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.MOUSE_OVER :
					this.gotoAndStop(2);
					break;
				case MouseEvent.MOUSE_OUT :
					this.gotoAndStop(1);
					break;
				case MouseEvent.MOUSE_DOWN :
					this.gotoAndStop(3);
					break;
			}
		}
	}

}