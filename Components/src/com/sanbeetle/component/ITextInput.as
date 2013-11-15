package com.sanbeetle.component {
	import com.sanbeetle.skin.ITextInputSkin_over;
	import com.sanbeetle.skin.ITextInputSkin_up;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.text.TextFieldType;
	
	
	
	
	public class ITextInput extends ILabel {
		
		private var upSkin:ITextInputSkin_up;
		private var overSkin:ITextInputSkin_over;
		
		private var _maxChars:int=0;
		
		private var currentSkin:DisplayObject;
		private var _displayAsPassword:Boolean=false;
		private var _restrict:String=null;
		
		private var _background:Boolean =true;
		
		public function ITextInput() {
			upSkin = new ITextInputSkin_up;
			overSkin = new ITextInputSkin_over;
			
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseHandler);
			
			currentSkin =upSkin;
		}		
		[Inspectable(defaultValue = true)]
		public function get background():Boolean
		{
			return _background;
		}		
		public function set background(value:Boolean):void
		{
			_background = value;
			this.updateUI();
			/*if(_background){
				upSkin.visible =true;
				overSkin.visible =true;
			}else{
				upSkin.visible =false;
				overSkin.visible =false;
			}*/
		}

		[Inspectable()]
		public function get restrict():String
		{
			return _restrict;
		}

		public function set restrict(value:String):void
		{
			_restrict = value;
			this.updateUI();
			
		}
		[Inspectable(defaultValue = false)]
		public function get displayAsPassword():Boolean
		{
			return _displayAsPassword;
		}

		public function set displayAsPassword(value:Boolean):void
		{
			_displayAsPassword = value;
			
			this.updateUI();
		}
		[Inspectable(defaultValue =0)]
		public function get maxChars():int
		{
			return _maxChars;
		}

		public function set maxChars(value:int):void
		{
			_maxChars = value;
			updateUI();
		}

		private function onMouseHandler(event:MouseEvent):void
		{			
			switch(event.type){
				case MouseEvent.MOUSE_OUT:
					currentSkin = upSkin;
					break;
				case MouseEvent.MOUSE_OVER:
					currentSkin = overSkin;
					break;
			}
			
			currentSkin.width = this.trueWidth;
			currentSkin.height = this.trueHeight;	
			
			updateUI();
		}
		
		override protected function updateUI():void
		{
			
			currentSkin.width = this.trueWidth;
			currentSkin.height = this.trueHeight;	
			
			
			
			if(background){
				currentSkin.visible =true;
				this.addChildAt(currentSkin,0);
			}else{
				currentSkin.visible =false;
				if(currentSkin.parent){
					this.removeChild(currentSkin);
				}
				
			}	
			
			this.addChild(textfield);
			super.updateUI();
			
			
			//textfield.width = this.trueWidth;
			//textfield.height = this.trueHeight;
			
			if(_restrict==""){
				this.textfield.restrict=null;
			}else{
				this.textfield.restrict=_restrict;
			}
			this.textfield.maxChars =_maxChars;
			this.textfield.displayAsPassword = _displayAsPassword;
			
		}		
		
		override protected function createUI():void
		{
			textfield.type = TextFieldType.INPUT;
			this.selectable =true;
			
			currentSkin.width = this.trueWidth;
			currentSkin.height = this.trueHeight;
			
			this.addChild(currentSkin);
			
			super.createUI();			
			
		}
		
	}
	
}
