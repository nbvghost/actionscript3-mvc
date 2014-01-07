package com.sanbeetle.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.tlf_internal;
	import flashx.textLayout.container.TextContainerManager;
	import flashx.textLayout.elements.IConfiguration;
	
	public class ExtendsTextContainerManager extends TextContainerManager
	{
		public function ExtendsTextContainerManager(container:Sprite, configuration:IConfiguration=null)
		{
			
			super(container, configuration);
		}
		
		override public function focusChangeHandler(event:FocusEvent):void
		{
			// TODO Auto Generated method stub
			super.focusChangeHandler(event);
		}
		
		override public function focusInHandler(event:FocusEvent):void
		{
			// TODO Auto Generated method stub
			super.focusInHandler(event);
		}
		
		override public function focusOutHandler(event:FocusEvent):void
		{
			// TODO Auto Generated method stub
			super.focusOutHandler(event);
		}
		
		override public function mouseOutHandler(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.mouseOutHandler(event);
		}
		
		override public function mouseOverHandler(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.mouseOverHandler(event);
		}
		
		override public function mouseUpHandler(event:MouseEvent):void
		{
			// TODO Auto Generated method stub
			super.mouseUpHandler(event);
		}
		
		override public function mouseUpSomewhere(e:Event):void
		{
			// TODO Auto Generated method stub
			super.mouseUpSomewhere(e);
		}
		
		
		
	}
}