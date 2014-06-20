package com.sanbeetle.component {
	import com.sanbeetle.core.TextBox;
	import com.sanbeetle.core.TextImage;
	import com.sanbeetle.skin.ITextInputSkin_over;
	import com.sanbeetle.skin.ITextInputSkin_up;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLVariables;
	import flash.text.TextFieldType;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.edit.ISelectionManager;
	import flashx.textLayout.elements.InlineGraphicElement;
	import flashx.textLayout.elements.InlineGraphicElementStatus;
	import flashx.textLayout.elements.ParagraphElement;
	import flashx.textLayout.events.StatusChangeEvent;
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.undo.UndoManager;
	
	
	
	[Event(name="inlineGraphicStatusChange", type="flashx.textLayout.events.StatusChangeEvent")]
	public class ITextInput extends TextBox {
		
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
			
			
			
			
			currentSkin =upSkin;	
			
			multiline = false;
			
			
			paddingTop = 6;
			paddingLeft = 3;
			paddingBottom = 3;
			paddingRight = 3;
			
			
		}		
		
		public function get enableEdit():Boolean
		{
			return _enableEdit;
		}
		
		public function set enableEdit(value:Boolean):void
		{
			_enableEdit = value;
			
			if(isRichText){
				if(_enableEdit){
					textContainerManager.editingMode = EditingMode.READ_WRITE;
				}else{
					textContainerManager.editingMode = EditingMode.READ_ONLY;
				}
			}else{
				if(_enableEdit){
					this.textField.type = TextFieldType.INPUT;
				}else{
					this.textField.type = TextFieldType.DYNAMIC;
				}
			}		
			
		}
		
		/**
		 * 可编辑管理器 
		 * @return 
		 * 
		 */
		public function get editManager():EditManager{
			
			if(isRichText){
				return this.textContainerManager.getTextFlow().interactionManager as EditManager;
				
			}else{
				return new EditManager();				
			}
			
		}		
		
		private function graphicStatusChangeEvent(e:StatusChangeEvent):void
		{
			if (e.status == InlineGraphicElementStatus.READY || e.status == InlineGraphicElementStatus.SIZE_PENDING)
			{
				textContainerManager.updateContainer();
			}
			
			this.dispatchEvent(new StatusChangeEvent(e.type,e.bubbles,e.cancelable,e.element,e.status,e.errorEvent));
		}
		
		public function noneLayoutText(value:String):void{
			_text = value;
			this.updateUI();
		}
		override protected function addTextFlowEvent():void
		{
			super.addTextFlowEvent();
			if(isRichText)
				textContainerManager.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,graphicStatusChangeEvent);
			
		}
		
		override protected function removeTextFlowEvent():void
		{
			// TODO Auto Generated method stub
			super.removeTextFlowEvent();
			if(isRichText)
				textContainerManager.removeEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,graphicStatusChangeEvent);
		}
		public function addImage(url:Object,w:int=20,h:int=20,format:ITextLayoutFormat=null):InlineGraphicElement{
			
			if(isRichText){
				
				var img:InlineGraphicElement = new InlineGraphicElement();
				img.source = url;
				img.width = w;
				img.height = h;
				img.format = format;
				
				
				
				
				
				var em:EditManager = textContainerManager.getTextFlow().interactionManager as EditManager;
				
				this.setFocus();
				
				if(em){				
					
					//em.selectAll();
					
					//em.selectRange(em.absoluteEnd,em.absoluteEnd);
					
					//em.insertInlineGraphic(url,w,h,format);
					
					//return img;
				}
				
				//textContainerManager.getTextFlow().getLastLeaf().getParagraph().addChild(img);
				
				var p:ParagraphElement = textContainerManager.getTextFlow().getChildAt(textContainerManager.getTextFlow().numChildren-1) as ParagraphElement;
				
				if(p){				
					p.addChild(img);
				}
				textContainerManager.updateContainer();
				return img;
				
			}else{
				var timg:TextImage = new TextImage();
				timg.setBoundaries(new Rectangle(0,0,w,h));
				if(url is String){
					var urlvar:URLVariables = new URLVariables();
					urlvar.source=url;
					timg.setImageData(urlvar);
				}else if(url is DisplayObject){
					timg.addDisplayObject(DisplayObject(url));				
				}else{
					
				}
				this.addTextImage(timg);
				return null;
			}
		}
		
		override protected function interactionManager():ISelectionManager
		{
			if(isRichText){
				if(_enableEdit){
					textContainerManager.editingMode = EditingMode.READ_WRITE;
					return new EditManager(new UndoManager());
					
				}else{
					textContainerManager.editingMode = EditingMode.READ_ONLY;
					//textContainerManager.editingMode = EditingMode.READ_SELECT;
					//return null;
					return new EditManager(new UndoManager());
				}
			}else{
				return null;
			}
			
			
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
		}
		
		public function get restrict():String
		{
			return _restrict;
		}
		
		[Deprecated(message="这不用了，请使用，请使用  ITextInput.regExp 默认过滤非 int 类型")]
		public function set restrict(value:String):void
		{
			if(_restrict !== value && value!=null){
				_restrict = value;				
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
		
		override protected function updateUI():void
		{
			
			textInputBackground();
			
			super.updateUI();
			textInputBackground();
		}	
		protected function textInputBackground():void
		{
			if(currentSkin){
				currentSkin.width = this.width;
				currentSkin.height = this.height;
				
				if(background){
					currentSkin.visible =true;
					this.addChildAt(currentSkin,0);
				}else{
					currentSkin.visible =false;
					if(currentSkin.parent){
						this.removeChild(currentSkin);
					}
					
				}				
			}
			//trace("ss",this.width,this.height);
		}
		
		override protected function createUI():void
		{
			
			this.selectable =true;
			
			currentSkin.width = this.width;
			currentSkin.height = this.height;
			
			
			
			
			//this.addChildAt(currentSkin,0);
			
			super.createUI();			
			this.updateUI();
			
		}		
		
	}
}
