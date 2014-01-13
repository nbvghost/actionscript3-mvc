package com.sanbeetle.component {
	import com.sanbeetle.skin.ITextInputSkin_over;
	import com.sanbeetle.skin.ITextInputSkin_up;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.edit.ISelectionManager;
	import flashx.textLayout.events.FlowOperationEvent;
	import flashx.undo.UndoManager;
	
	
	
	
	public class ITextInput extends ILabel {
		
		private var upSkin:ITextInputSkin_up;
		private var overSkin:ITextInputSkin_over;
		
		
		
		private var currentSkin:DisplayObject;
		private var _displayAsPassword:Boolean=false;
		private var _restrict:String=null;
		
		private var _background:Boolean =true;
		
		
		private var _enableEdit:Boolean = true;
		
		
		
		public function ITextInput() {
			
			upSkin = new ITextInputSkin_up;
			overSkin = new ITextInputSkin_over;
			
			
			upSkin.mouseChildren = false;
			upSkin.mouseEnabled = false;
			
			
			overSkin.mouseChildren = false;
			overSkin.mouseEnabled = false;
			
			
			
			//this.addEventListener(MouseEvent.MOUSE_OVER,onMouseHandler);
			//this.addEventListener(MouseEvent.MOUSE_OUT,onMouseHandler);
			
			currentSkin =upSkin;	
			
			multiline = false;
			
			
			//textfield.type = TextFieldType.INPUT;
			
		}		

		public function get enableEdit():Boolean
		{
			return _enableEdit;
		}

		public function set enableEdit(value:Boolean):void
		{
			_enableEdit = value;
			if(_enableEdit){
				textContainerManager.editingMode = EditingMode.READ_WRITE;
			}else{
				textContainerManager.editingMode = EditingMode.READ_ONLY;
			}
		}

		/**
		 * 可编辑管理器 
		 * @return 
		 * 
		 */
		public function get editManager():EditManager{
			return this.textContainerManager.getTextFlow().interactionManager as EditManager;
			
		}
		
		override protected function onFlowOperationBedginHandler(event:FlowOperationEvent):void
		{
			super.onFlowOperationBedginHandler(event);
	
			
			/*var intotxt:InsertTextOperation = event.operation as InsertTextOperation;
			
			var str:String;
			
			if(intotxt){
				str = text+intotxt.text;
				if(_regExp!=null){
					//Log.out(_text+intotxt.text);
					if(!_regExp.test(str)){
						//editManager.undoManager.undo();
						event.preventDefault();
					}
				}
				
				var txtlent:int = getStringBytesLength(str,"gb2312");
				//Log.out(txtlent,str);
				if(txtlent > maxChars && maxChars > 0)  
				{  
					event.preventDefault();				
				}
			}*/
			
			
			
			
			
		}
		
		
		override protected function interactionManager():ISelectionManager
		{
			if(_enableEdit){
			textContainerManager.editingMode = EditingMode.READ_WRITE;
				
			}else{
				textContainerManager.editingMode = EditingMode.READ_ONLY;
			}
			
			return new EditManager(new UndoManager());
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
		
		//[Inspectable()]
		public function get restrict():String
		{
			return _restrict;
		}
		
		[Deprecated(message="这不用了，请使用，请使用  ITextInput.regExp 默认过滤非 int 类型")]
		public function set restrict(value:String):void
		{
			if(_restrict !== value && value!=null){
				_restrict = value;
				//this.regExp=RegExpType.INT;
				//this.updateUI();
			}			
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
			
			//currentSkin.width = this.trueWidth;
			//currentSkin.height = this.trueHeight;	
			
			updateUI();
		}
		
		override public function updateUI():void
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
			
			
			super.updateUI();
			
			//this.addChild(container);
			//textfield.width = this.trueWidth;
			//textfield.height = this.trueHeight;
			
			
			
			
			if(_restrict==""){
				//this.textfield.restrict=null;
			}else{
				//this.textfield.restrict=_restrict;
			}
			
			
			//this.textfield.maxChars =_maxChars;
			//this.textfield.displayAsPassword = _displayAsPassword;
			
		}		
		
		override public function createUI():void
		{
			
			this.selectable =true;
			
			currentSkin.width = this.trueWidth;
			currentSkin.height = this.trueHeight;
			
			paddingTop = 6;
			paddingLeft = 3;
			paddingBottom = 3;
			paddingRight = 3;
			
			this.addChildAt(currentSkin,0);
			
			
			
			super.createUI();			
			
		}		
		
	}
}
