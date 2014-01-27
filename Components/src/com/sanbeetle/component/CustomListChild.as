package com.sanbeetle.component {
	import com.asvital.dev.Log;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.utils.Utils;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[Event(name="change", type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 * 项里面的内容 的事件 
	 */	
	[Event(name="item_renderer_select",type="com.sanbeetle.events.ControlEvent")]
	
	
	public class CustomListChild extends UIComponent {
		private var _targetName:String="target";
		
		private var targetDisplay:InteractiveObject;
		
		private var list:ListChild;
		
		private var _dataProvider:DataProvider;
		
		public function CustomListChild() {
			// constructor code
			list =new ListChild();
			list.addEventListener(ControlEvent.CHANGE,onChangeHandler);
			list.addEventListener(ControlEvent.ITEM_RENDERER_SELECT,onItemRendererHandler);
			
		}
		
		protected function onItemRendererHandler(event:ControlEvent):void
		{
			this.dispatchEvent(new ControlEvent(event.type,event.data));
			hide();
			
		}
		private function hide():void{
			/*if(parentDisp.contains(this)){
			parentDisp.removeChild(this);
			
			if(parentDisp.stage){
			parentDisp.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseUphandler);
			}
			}*/
			stage.removeChild(list);
		}
		protected function onChangeHandler(event:ControlEvent):void
		{
			// TODO Auto-generated method stub
			this.dispatchEvent(new ControlEvent(event.type,event.data));
			hide();
		}
		[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}
		
		public function set dataProvider(value:DataProvider):void
		{
			_dataProvider = value;
			list.dataProvider = _dataProvider;
		}
		
		[Inspectable(defaultValue="target")]
		public function get targetName():String
		{
			return _targetName;
		}
		
		public function set targetName(value:String):void
		{			
			if(_targetName!=value){
				_targetName = value;
				this.updateUI();
			}						
		}
		
		
		override public function createUI():void
		{
			
			
			if(this.parent==null){
				return;
			}
			this.targetDisplay  = this.parent.getChildByName(_targetName) as InteractiveObject;				
			//Log.out(targetDisplay);
			if(targetDisplay){
				//this.x = targetDisplay.x;
				//this.y = targetDisplay.y+targetDisplay.height;
				
				var point:Point = this.parent.localToGlobal(new Point(targetDisplay.x,targetDisplay.y+targetDisplay.height));
				
				list.x = point.x;
				list.y = point.y;
				
				//this.visible=false;					
				//parentDisp.removeChild(this);
				list.setMinWidth(targetDisplay.width+25);
				list.setMaxHeight(300);
				targetDisplay.addEventListener(MouseEvent.MOUSE_UP,onTargetDownHandler);
			}else{
				Log.out(" 没有找到 "+_targetName+" 实例！");
			}			
			
		}
		
		override public function dispose():void
		{
			if(list){
				list.removeEventListener(ControlEvent.CHANGE,onChangeHandler);
				list.removeEventListener(ControlEvent.ITEM_RENDERER_SELECT,onItemRendererHandler);
				if(list.parent){
					list.parent.removeChild(list);
				}
			}
			if (targetDisplay) 
			{
				
				targetDisplay.removeEventListener(MouseEvent.MOUSE_UP,onTargetDownHandler);
				targetDisplay =null;
			}
			if(stage){				
				stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUphandler);
			}
			
			super.dispose();
		}
		
		
		protected function onTargetDownHandler(event:MouseEvent):void
		{	
			
			if(stage.contains(list)){
				stage.removeChild(list);
				stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUphandler);
			}else{
				
				var point:Point = this.parent.localToGlobal(new Point(targetDisplay.x,targetDisplay.y+targetDisplay.height));
				
				list.x = point.x;
				list.y = point.y;
				stage.addChild(list);
				stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUphandler);
			}
			
			
			/*parentDisp.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseUphandler);
			if(parentDisp.contains(this)){
			
			parentDisp.removeChild(this);
			
			//parentDisp.stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseUphandler);
			}else{
			this.x = targetDisplay.x;
			this.y = targetDisplay.y+targetDisplay.height;
			parentDisp.addChild(this);
			//this.visible=true;				
			parentDisp.stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseUphandler);
			
			}*/
			
			
			
		}
		
		protected function onMouseUphandler(event:MouseEvent):void
		{
			
			trace(event.target,event.currentTarget);
			if(!Utils.isChild(this,event.target as DisplayObject) && !Utils.isChild(targetDisplay,event.target as DisplayObject) && !Utils.isChild(list,event.target as DisplayObject)){
				
				if (stage) 
				{
					
					if(stage.contains(list)){
						
						stage.removeChild(list);
					}
					stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUphandler);
				}
			}			
			
		}
	}
	
}
