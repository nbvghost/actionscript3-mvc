package com.sanbeetle.component {
	
	import com.asvital.dev.Console;
	import com.sanbeetle.component.child.IListBox;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.SimpleCollectionItem;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.skin.IListBoxBgA;
	import com.sanbeetle.skin.ISideBoxBtn;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[Event(name="change", type="com.sanbeetle.events.ControlEvent")]
	
	public class ISideBox extends UIComponent {
		
		private var collectionItemImport:SimpleCollectionItem;
		private var _dataProvider:DataProvider;
		
		private var sideBoxSkin:IListBox;		
		private var _boxWidth:int = 120;
		
		private var tels:ISideBoxBtn;
		
		public function ISideBox() {
			tels = new ISideBoxBtn();
			tels.mouseChildren =false;
			tels.stop();
			sideBoxSkin = new IListBox(new IListBoxBgA);	
			sideBoxSkin.addEventListener(ControlEvent.CHANGE,onContentClickHandler);
			
			
			
			//this.trueWidth = 52;
			//this.trueHeight =32;
			this.width = 52;
			this.height=32;
			
		}		
		[Inspectable(defaultValue = 120)]
		public function get boxWidth():int
		{
			return _boxWidth;
		}
		
		public function set boxWidth(value:int):void
		{
			
			_boxWidth = value;	
			
			sideBoxSkin.width = _boxWidth;	
			sideBoxSkin.listWidth = _boxWidth;
			
			this.updateUI();
			
		}
		
		override protected function updateUI():void
		{
			Console.out("components"+_boxWidth);
			sideBoxSkin.width = _boxWidth;	
			sideBoxSkin.listWidth = _boxWidth;
			
		}
		
		
		override protected function createUI():void
		{	
			
			this.addChild(tels);
			
			
			this.buttonMode =true;						
			
			
			addChild(sideBoxSkin);		
			
			
			//resetPoint();
			
			
			//sideBoxSkin.width = _boxWidth;	
			//sideBoxSkin.listWidth = _boxWidth;
			
			sideBoxSkin.visible =false;
			
			tels.addEventListener(MouseEvent.MOUSE_DOWN,onMouseHandler);
			tels.addEventListener(MouseEvent.MOUSE_OUT,onMouseHandler);
			tels.addEventListener(MouseEvent.MOUSE_OVER,onMouseHandler);
			//tels.addEventListener(MouseEvent.MOUSE_UP,onMouseHandler);
			tels.addEventListener(MouseEvent.CLICK,onManinClickHandler);			
			
			sideBoxSkin.filters=this.component.isideBoxFilters;
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
			//Console.out("components"+event.toString());
			if(sideBoxSkin!=null){
				sideBoxSkin.visible =false;
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
			
			
			
		}
		
		private function resetPoint():void{
			
			if(this.stage==null){
				return;
			}
			sideBoxSkin.x = -(sideBoxSkin.width+2);
			//Console.out("components"+sideBoxContent.width);
			//return;
			sideBoxSkin.y = 0;
			this.addChild(sideBoxSkin);
			//Console.out("components"+sideBoxContent.y);
			var localPoint:Point = this.localToGlobal(new Point(sideBoxSkin.x,sideBoxSkin.y));
			//return;
			stage.addChild(sideBoxSkin);
			//Console.out("components"+stage.numChildren);
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
