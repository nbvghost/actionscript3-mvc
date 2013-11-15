﻿package com.sanbeetle.component {
	
	import com.sanbeetle.component.child.ICheckBoxSkin;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	
	import flash.events.MouseEvent;
	
	[Event(name="change",type="com.sanbeetle.events.ControlEvent")]
	public class ICheckBox extends UIComponent {
		
		private var skin:ICheckBoxSkin;
		private var _select:Boolean = false;
		public function ICheckBox() {
			skin = new ICheckBoxSkin();
			skin.icon.visible =_select;
			this.addChild(skin);
			this.addEventListener(MouseEvent.CLICK,onClickHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,onMouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseEventHandler);
			this.addEventListener(MouseEvent.MOUSE_UP,onMouseEventHandler);
			
		}
		
		protected function onMouseEventHandler(event:MouseEvent):void
		{
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					skin.bg.gotoAndStop(3);
					break;
				case MouseEvent.MOUSE_OUT:
					skin.bg.gotoAndStop(1);
					break;
				case MouseEvent.MOUSE_OVER:
					skin.bg.gotoAndStop(2);
					break;
				case MouseEvent.MOUSE_UP:
					skin.bg.gotoAndStop(1);
					break;
			}
		}
		
		private function onClickHandler(event:MouseEvent):void
		{
			if(_select){
				this.select = false;
			}else{
				this.select = true;
			}
			this.dispatchEvent(new ControlEvent(ControlEvent.CHANGE));
		}
		[Inspectable(defaultValue = false)]
		public function get select():Boolean
		{
			return _select;
		}
		
		public function set select(value:Boolean):void
		{
			_select = value;
			
			skin.icon.visible = _select;
		}
		
	}
	
}
