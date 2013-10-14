package com.sanbeetle.component {
	
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.IListBox;
	import com.sanbeetle.skin.IListBoxItem;
	import com.sanbeetle.skin.ISideBoxBtn;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	import fl.data.DataProvider;
	import fl.data.SimpleCollectionItem;
	
	[Event(name="change", type="com.sanbeetle.events.ControlEvent")]
	
	public class ISideBox extends UIComponent {
		
		private var collectionItemImport:SimpleCollectionItem;
		private var _dataProvider:DataProvider;
		
		private var sideBoxSkin:IListBox;		
		private var _boxWidth:int = 120;
		
		private var tels:ISideBoxBtn;
		
		public function ISideBox() {
			tels = new ISideBoxBtn();
			sideBoxSkin = new IListBox();	
			
			this.trueWidth = 52;
			this.trueHeight =32;
		}		
		[Inspectable(defaultValue = 120)]
		public function get boxWidth():int
		{
			return _boxWidth;
		}

		public function set boxWidth(value:int):void
		{
			_boxWidth = value;
		}

		override protected function createUI():void
		{	
			
			
			this.addChild(tels);
								
			
			this.buttonMode =true;						
			
			
			addChild(sideBoxSkin);
			
			//resetPoint();
			
			
			sideBoxSkin.visible =false;
			
			tels.addEventListener(MouseEvent.CLICK,onManinClickHandler);
			
			sideBoxSkin.filters=[new DropShadowFilter(1, 60, 0x000000, 0.3, 10, 10, 1,BitmapFilterQuality.LOW, false, false)];
		}
		
		protected function onContentClickHandler(event:MouseEvent):void
		{
			//trace(event.target);
			//trace(ISideBoxSkinItem(event.target).simpleCollectionItem.label);
			if(event.target is IListBoxItem){
				this.dispatchEvent(new ControlEvent(ControlEvent.CHANGE,IListBoxItem(event.target).data));
			}
			
		}
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return trueHeight;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return trueWidth;
		}
		
		
		protected function onManinClickHandler(event:MouseEvent):void
		{
			//trace(event);		
			sideBoxSkin.visible =true;
			stage.addEventListener(MouseEvent.MOUSE_UP,onStageUpHandler);
			resetPoint();
		}
		
		override protected function onStageHandler(event:Event):void
		{		
			
			resetPoint();
		}
		
		
		protected function onStageUpHandler(event:MouseEvent):void
		{
			//trace(event.toString());
			if(sideBoxSkin!=null){
				sideBoxSkin.visible =false;
			}
			
			stage.removeEventListener(MouseEvent.MOUSE_UP,onStageUpHandler);
			
		}
		[Collection(collectionClass="fl.data.DataProvider", identifier="item", collectionItem="fl.data.SimpleCollectionItem")]
		/**
		 * @copy fl.controls.SelectableList#dataProvider
		 *
		 * @see fl.data.DataProvider DataProvider
		 *
		 * @includeExample examples/ComboBox.dataProvider.1.as -noswf
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 *  
		 *  @playerversion AIR 1.0
		 *  @productversion Flash CS3
		 */
		public function get dataProvider():DataProvider {
			return _dataProvider;
		}
		
		/**
		 * @private (setter)
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		public function set dataProvider(value:DataProvider):void {
			_dataProvider = value;
			
			sideBoxSkin.width = _boxWidth;		
			sideBoxSkin.dataProvider =  value;
					
		}
		
		private function resetPoint():void{
			
			if(this.stage==null){
				return;
			}
			sideBoxSkin.x = -sideBoxSkin.width;
			//trace(sideBoxContent.width);
			//return;
			sideBoxSkin.y = 0;
			this.addChild(sideBoxSkin);
			//trace(sideBoxContent.y);
			var localPoint:Point = this.localToGlobal(new Point(sideBoxSkin.x,sideBoxSkin.y));
			//return;
			stage.addChild(sideBoxSkin);
			//trace(stage.numChildren);
			stage.setChildIndex(sideBoxSkin,stage.numChildren-1);
			
			sideBoxSkin.x = localPoint.x;
			sideBoxSkin.y = localPoint.y;
			
			if((sideBoxSkin.y+sideBoxSkin.height)>stage.stageHeight){
				sideBoxSkin.y = stage.stageHeight-sideBoxSkin.height;
			}
			if((sideBoxSkin.x)<0){
				localPoint = this.localToGlobal(new Point(tels.x,tels.y));
				
				//sideBoxSkin.x = localPoint.x+this.width;
				sideBoxSkin.x =localPoint.x+tels.width;
			}
		}
	}
	
}
