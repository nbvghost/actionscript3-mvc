package com.sanbeetle.component {
	
	import com.sanbeetle.component.child.IListBox;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.SimpleCollectionItem;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.IListBoxBg;
	import com.sanbeetle.skin.ISideBoxBtn;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[Event(name="change", type="com.sanbeetle.events.ControlEvent")]
	
	[Event(name="item_select", type="com.sanbeetle.events.ControlEvent")]
	
	public class ISideBox extends UIComponent {
		
		private var collectionItemImport:SimpleCollectionItem;
		private var _dataProvider:DataProvider;
		
		private var sideBoxSkin:IListBox;		
		
		private var tels:ISideBoxBtn;
		
		private var bg:IListBoxBg;
		
		private var box:Sprite;
		
		public function ISideBox() {
			
			bg = new IListBoxBg();
			
			tels = new ISideBoxBtn();
			tels.mouseChildren =false;
			tels.stop();
			sideBoxSkin = new IListBox(null);	
			sideBoxSkin.addEventListener(ControlEvent.CHANGE,onContentClickHandler);
			sideBoxSkin.addEventListener(ControlEvent.ITEM_SELECT,onConteseleHane);
			//sideBoxSkin.ItemCellRender = BlackColorListCellRenderer;
			sideBoxSkin.autoSize =true;
			sideBoxSkin.setMinWidth(this.component.getMinListWidth());
			//this.trueWidth = 52;
			//this.trueHeight =32;
			this.width = 52;
			this.height=32;		
			
			
			
			
			
			box=new Sprite();
		}	
		
		override public function dispose():void
		{
			// TODO Auto Generated method stub
			super.dispose();
			
			
			
			sideBoxSkin.removeEventListener(ControlEvent.CHANGE,onContentClickHandler);
			sideBoxSkin.removeEventListener(ControlEvent.ITEM_SELECT,onConteseleHane);
			
			
			if(sideBoxSkin.parent){
				sideBoxSkin.parent.removeChild(sideBoxSkin);
			}
			
			tels.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseHandler);
			tels.removeEventListener(MouseEvent.MOUSE_OUT,onMouseHandler);
			tels.removeEventListener(MouseEvent.MOUSE_OVER,onMouseHandler);
			//tels.addEventListener(MouseEvent.MOUSE_UP,onMouseHandler);
			tels.removeEventListener(MouseEvent.CLICK,onManinClickHandler);	
			
			if(stage){
				stage.removeEventListener(MouseEvent.MOUSE_UP,onStageUpHandler);
			}
		}
		
		
		protected function onConteseleHane(event:ControlEvent):void
		{
			// TODO Auto-generated method stub
			this.dispatchEvent(new ControlEvent(event.type,event.data));
		}
		override public function updateUI():void
		{
			
			//sideBoxSkin.listWidth = _boxWidth;
			/*bg.bg.width = sideBoxSkin.width;
			bg.bg.height = sideBoxSkin.height;*/
			
			bg.bg.width = sideBoxSkin.width+2;
			bg.bg.height = sideBoxSkin.height+18;
		}
		
		
		override public function createUI():void
		{	
			
			this.addChild(tels);
			
			
			this.buttonMode =true;						
			
			
				
			
			
			//resetPoint();
			
			
			
			
			
			box.addChild(bg);
			box.addChild(sideBoxSkin);
			
			
			
			tels.addEventListener(MouseEvent.MOUSE_DOWN,onMouseHandler);
			tels.addEventListener(MouseEvent.MOUSE_OUT,onMouseHandler);
			tels.addEventListener(MouseEvent.MOUSE_OVER,onMouseHandler);
			//tels.addEventListener(MouseEvent.MOUSE_UP,onMouseHandler);
			tels.addEventListener(MouseEvent.CLICK,onManinClickHandler);	
			
			//sideBoxSkin.filters=this.component.isideBoxFilters;
			
			
			
			updateUI();
		}
		
		protected function onMouseHandler(event:MouseEvent):void
		{
			//Console.out("components"+event.type);
			switch(event.type){
				case MouseEvent.MOUSE_DOWN:
					tels.gotoAndStop(3);
					//onManinClickHandler(event);
					break;
				case MouseEvent.MOUSE_OUT:
					tels.gotoAndStop(1);
					break;
				case MouseEvent.MOUSE_OVER:
					tels.gotoAndStop(2);
					break;
				case MouseEvent.MOUSE_UP:
					tels.gotoAndStop(1);
					break;
			}
			
		}
		
		protected function onContentClickHandler(event:ControlEvent):void
		{
			//Console.out("components"+event.target);
			//Console.out("components"+ISideBoxSkinItem(event.target).simpleCollectionItem.label);			
			this.dispatchEvent(new ControlEvent(ControlEvent.CHANGE,event.data));		
			
		}	
		
		protected function onManinClickHandler(event:MouseEvent):void
		{
			//Console.out("components"+event);
			
		
			stage.addEventListener(MouseEvent.MOUSE_UP,onStageUpHandler);
			resetPoint();
			
			
			
			this.sideBoxSkin.upDisplayList();
			updateUI();
		}
		
		override public function onStageHandler(event:Event):void
		{		
			
			//resetPoint();
		}
		
		override protected function onAddStage():void
		{
			// TODO Auto Generated method stub
			super.onAddStage();
			
			sideBoxSkin.upDisplayList();
		}	
		
		protected function onStageUpHandler(event:MouseEvent):void
		{
			//Console.out("components"+event.toString());
		
				if(box.parent){
					box.parent.removeChild(box);
				}		
			
			stage.removeEventListener(MouseEvent.MOUSE_UP,onStageUpHandler);
			
		}
		[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
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
			
			sideBoxSkin.dataProvider =  value;			
			
			
			updateUI();
		}
		
		private function resetPoint():void{
			
			if(this.stage==null){
				return;
			}
			
			//box.addChild(bg);
			//box.addChild(sideBoxSkin);
			
			sideBoxSkin.x=1;
			sideBoxSkin.y = 9;
			
			
			
		
			
			addChild(box);	
			
			
			box.x = -(box.width+2);
			//Console.out("components"+sideBoxContent.width);
			//return;
			box.y = 0;
			
			//Console.out("components"+sideBoxContent.y);
			var localPoint:Point = this.localToGlobal(new Point(box.x,box.y));
			//return;
			stage.addChild(box);
			//Console.out("components"+stage.numChildren);
			stage.setChildIndex(box,stage.numChildren-1);
			
			box.x = localPoint.x;
			box.y = localPoint.y;
			
			if((box.y+box.height)>stage.stageHeight){
				box.y = stage.stageHeight-box.height;
			}
			if((box.x)<0){
				localPoint = this.localToGlobal(new Point(tels.x,tels.y));
				
				//box.x = localPoint.x+this.width;
				box.x =localPoint.x+tels.width;
			}
			updateUI();
		}
	}
	
}
