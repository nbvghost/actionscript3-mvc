package com.sanbeetle.component {
	
	import com.sanbeetle.core.TextBox;
	
	import flashx.textLayout.edit.EditManager;
	import flashx.textLayout.edit.EditingMode;
	import flashx.textLayout.edit.ISelectionManager;
	import flashx.textLayout.elements.InlineGraphicElementStatus;
	import flashx.textLayout.events.FlowElementMouseEvent;
	import flashx.textLayout.events.StatusChangeEvent;
	
	
	public class IRichText extends TextBox {
	
	
		private var _enableEdit:Boolean =false;

		//private var context:Sprite;
		public function IRichText() {
			
		}		
		
		[Inspectable(defaultValue=false)]
		public function get enableEdit():Boolean
		{
			return _enableEdit;
		}
		
		public function set enableEdit(value:Boolean):void
		{
			if(_enableEdit!=value){
				_enableEdit = value;
				this.updateUI();
			}			
		}		
		override protected function addTextFlowEvent():void
		{
			// TODO Auto Generated method stub
			super.addTextFlowEvent();
			
			textContainerManager.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,graphicStatusChangeEvent);
		}
		
		override protected function onFlowElementMouseDownHandler(event:FlowElementMouseEvent):void
		{
			// TODO Auto Generated method stub
			super.onFlowElementMouseDownHandler(event);
			
			
			//trace(_textFlow.getElementsByStyleName("aaaa"),"999")
		}
		
		
		override protected function removeTextFlowEvent():void
		{
			// TODO Auto Generated method stub
			super.removeTextFlowEvent();
			textContainerManager.removeEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,graphicStatusChangeEvent);
		}
		/**
		 * 
		 * 
		 * @param xmlStr  <code><TextFlow color="#333333" fontFamily="微软雅黑" fontSize="12" fontWeight="normal" paddingLeft="0" paddingTop="0" whiteSpaceCollapse="preserve" version="3.0.0" xmlns="http://ns.adobe.com/textLayout/2008"></TextFlow></code>
		 * 
		 */		
		/*public function createTextFlow(xmlStr:String=null):void{
			this.removeTextFlowEvent();
			if(xmlStr!=null){
				_textFlow = TextConverter.importToFlow(xmlStr, TextConverter.TEXT_LAYOUT_FORMAT);
			}else{
				_textFlow = TextConverter.importToFlow(this.component.getTextFlow(), TextConverter.TEXT_LAYOUT_FORMAT);
			}
			_textFlow.addChild(p);
			this.addTextFlowEvent();
		}		*/
		
		
		public function noneLayoutText(value:String):void{
			_text = value;
			this.updateUI();
		}		
		private function graphicStatusChangeEvent(e:StatusChangeEvent):void
		{
			// if the graphic has loaded update the display
			// actualWidth and actualHeight are computed from the graphic's height
			if (e.status == InlineGraphicElementStatus.READY || e.status == InlineGraphicElementStatus.SIZE_PENDING)
			{
				//_textFlow.flowComposer.updateAllControllers();
				textContainerManager.updateContainer();
			}
			
			//_textFlow.removeEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,graphicStatusChangeEvent);
		}
		
		override public function updateUI():void
		{
			super.updateUI();
			/*			
			if(this._enableEdit){
				_textFlow.interactionManager = new EditManager();
				//_textFlow.interactionManager.setFocus();
			}else{
				_textFlow.interactionManager =null;
			}
			
			
			_textFlow.flowComposer.updateAllControllers();*/
			
			//Log.out(this.width,this.height);
			
		}		
		
		override protected function interactionManager():ISelectionManager
		{
			if(this.enableEdit){
				textContainerManager.editingMode = EditingMode.READ_WRITE;
				return new EditManager();
			}else{
				textContainerManager.editingMode = EditingMode.READ_ONLY;
				return null;
			}		
		}		
		
		
		public function addImage(url:Object,w:int=20,h:int=20):void{
			
			var em:EditManager = textContainerManager.getTextFlow().interactionManager as EditManager;
			
			//trace(_textFlow.interactionManager);
			//var img:InlineGraphicElement = new InlineGraphicElement();
			//img.source = url;
			//img.width = w;
			//img.height = h;			
			//_textFlow.addChild(img);
			//p.addChild(img);
			//trace(_textFlow.getParagraph());
			if(em){
				em.insertInlineGraphic(url,w,h);	
				textContainerManager.addEventListener(StatusChangeEvent.INLINE_GRAPHIC_STATUS_CHANGE,graphicStatusChangeEvent);
				textContainerManager.addEventListener("inlineGraphicStatusChanged",graphicStatusChangeEvent);
				//_textFlow.flowComposer.updateAllControllers();
				this.updateUI();
			}
			
			
			
			
		}
		
	}
	
}
