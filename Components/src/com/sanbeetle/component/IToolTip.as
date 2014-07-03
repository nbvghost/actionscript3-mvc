package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.model.LocationRect;
	import com.sanbeetle.skin.ToolTipSkin;
	
	
	public class IToolTip extends UIComponent {
		
		
		private var skin:ToolTipSkin;
		private var contentTxt:IRichText;
		private var _text:String="defaultValue";
		private var rect:LocationRect;
		
		public function IToolTip() {
			skin = new ToolTipSkin();			
			contentTxt = new IRichText();
			contentTxt.addEventListener(ControlEvent.FONT_LOADED,onReHande);
			contentTxt.componentInspectorSetting = true;
			contentTxt.enableEdit =false;
			contentTxt.autoBound = true;
			contentTxt.multiline =false;
			contentTxt.color = "0x373b40";
			contentTxt.fontSize = "11";			
			contentTxt.componentInspectorSetting = false;
			rect = new LocationRect(9,11,9,11);
		}
		public function get textXML():String{
			
			return contentTxt.textXML;
		}
		public function set textXML(value:String):void{
			contentTxt.textXML = value;
			this.updateUI();
		}	
		
		protected function onReHande(event:ControlEvent):void
		{
			contentTxt.removeEventListener(ControlEvent.FONT_LOADED,onReHande);
			this.updateUI();
			
		}
		[Inspectable(defaultValue="defaultValue")]
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			_text = value;
			contentTxt.text = _text;
			updateUI();
		}
		override protected function createUI():void
		{
			
			skin.filters = component.irightMenuFilters;
			this.addChild(skin);			
			this.addChild(contentTxt);
			//this.width = component.getMaxToolTipWidth();
			updateUI();
		}
		
		override protected function updateUI():void
		{
			contentTxt.autoBound =true;
			contentTxt.multiline =false;
			
			if((contentTxt.width+rect.left+rect.right)>component.getMaxToolTipWidth()){
				//contentTxt.autoBound =false;
				contentTxt.multiline =true;
				//contentTxt.width = component.getMaxToolTipWidth();
				contentTxt.width = component.getMaxToolTipWidth()-rect.left-rect.right;
			}
			
			skin.width = contentTxt.width+rect.left+rect.right;
			
			contentTxt.x = rect.left;
			contentTxt.y = rect.top;
			skin.height = rect.top+rect.buttom+contentTxt.height;
			this.drawBorder(skin.width,skin.height);
			//Log.out(contentTxt.width);
		}
		
		
	}
	
}
