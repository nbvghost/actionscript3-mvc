package com.sanbeetle.component {
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.DataProvider;
	import com.sanbeetle.data.ListChildItem;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.events.DataChangeEvent;
	import com.sanbeetle.model.LocationRect;
	import com.sanbeetle.utils.Utils;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[Event(name="change", type="com.sanbeetle.events.ControlEvent")]
	
	[Event(name="item_select", type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 * 项里面的内容 的事件 
	 */	
	[Event(name="item_renderer_select",type="com.sanbeetle.events.ControlEvent")]
	
	public class ListChild extends UIComponent {
		
		private var listArr:Array=new Array;
		//private var childList:List;
		
		private var indexList:int=-1;
		
		private var _childList:List;
		
		private var _dataProvider:DataProvider;
		
		private var _itemCellRenaderer:Class;
		private var parnList:List;
		
		public function ListChild() {
			
			
			if(parnList==null){
				parnList = new List(null);
				parnList.autoSize =true;	
				parnList.addEventListener(ControlEvent.ITEM_OVER,onChildListItemOverHandler);
				parnList.addEventListener(ControlEvent.CHANGE,onChidlListItemChangeHandler);	
				parnList.addEventListener(ControlEvent.ITEM_SELECT,onChildListItemSelectHandler);
				parnList.addEventListener(ControlEvent.ITEM_RENDERER_SELECT,onItemRendererHandler);					
				this._childList = parnList;
			}
		}
		
		public function get itemCellRenaderer():Class
		{
			if(_childList){
				return _childList.ItemCellRender;
			}
			return _itemCellRenaderer;
		}
		
		public function set itemCellRenaderer(value:Class):void
		{
			if(_itemCellRenaderer != value){
				_itemCellRenaderer = value;
				this.updateUI();
			}
		}
		
		[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
		public function get dataProvider():DataProvider
		{
			return _dataProvider;
		}
		
		override protected function onAddStage():void
		{
			
			super.onAddStage();			
			this.upDisplayList();
			//this.updateUI();
		}
		
		override protected function onRemoveStage():void
		{
			
			super.onRemoveStage();
			this.cleanUp();
			
		}		
		public function set dataProvider(value:DataProvider):void
		{
			
			if(value!=null){
				if(_dataProvider !== value){
					_dataProvider = value;					
					if(_dataProvider){			
						
						_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE,onDataChangeHadnler);					
						_dataProvider.addEventListener(DataChangeEvent.DATA_CHANGE,onDataChangeHadnler);
					}
					
					
				}
			}else{
				if(_dataProvider){			
					
					_dataProvider.removeEventListener(DataChangeEvent.DATA_CHANGE,onDataChangeHadnler);				
					
				}
				this.cleanUp();				
				_dataProvider =null;
			}
			
		}
		private var _minWidth:int = -1;
		private var _maxHeight:int = -1;
		public function setMinWidth(w:int=-1):void{
			if(_minWidth != w){
				_minWidth = w;				
				//this.updateUI();
				parnList.setMinWidth(this._minWidth);
			}
			
		}
		public function setMaxHeight(h:int=-1):void{
			if(_maxHeight != h){
				_maxHeight = h;				
				this.updateUI();
			}
			
		}
		private function onDataChangeHadnler(event:DataChangeEvent):void
		{
			
			//this.updateUI();
			upDisplayList();
		}	
		
		protected function onItemRendererHandler(event:ControlEvent):void
		{
			
			this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_RENDERER_SELECT,event.data));
			
		}
		public function upDisplayList():void{
			
			this.updateUI();
			/*if(parnList){
			parnList.upDisplayList();
			}	*/	
			
		}
		public function get currentList():List
		{
			return _childList;
		}		
		public function cleanUp():void{
			var list:List;
			for(var i:int=0;i<listArr.length;i++){
				list = listArr[i];
				if(list){
					if(list.parent){
						list.parent.removeChild(list);
					}					
					list.cleanUp();
					//list.removeFromStage();
				}
			}			
			listArr.splice(0,listArr.length);			
			
		}
		private var isExtChild:Boolean = false;
		protected function onChildListItemOverHandler(event:ControlEvent):void
		{			
			
			var list:List = event.target as List;
			var listchidlitem:ListChildItem;
			
			var ccp:DisplayObjectContainer = list.currentItem as DisplayObjectContainer;
			
			var cu:Point = ccp.parent.localToGlobal(new Point(list.currentItem.x,list.currentItem.y));
			
			var teee:Point = this.globalToLocal(cu);
			
			
			if(list){
				listchidlitem = list.currentItem.data as ListChildItem;
				var childList:List;
				
				if(listchidlitem){
					
					
					if(listchidlitem.childs!=null){
						isExtChild= true;
						this.indexList = int(list.name)+1;					
						
						if(this.listArr[indexList]==undefined){
							childList= new List(list);							
							childList.ItemCellRender = _itemCellRenaderer;
							childList.autoSize =true;
							childList.setMinWidth(this.component.getMinListWidth());
							childList.column = indexList;							
							childList.name = String(indexList);
							childList.addEventListener(ControlEvent.ITEM_OVER,onChildListItemOverHandler,false,0,true);
							childList.addEventListener(ControlEvent.CHANGE,onChidlListItemChangeHandler,false,0,true);
							childList.addEventListener(ControlEvent.ITEM_RENDERER_SELECT,onItemRendererHandler);
							childList.addEventListener(ControlEvent.ITEM_SELECT,onChildListItemSelectHandler);
							childList.addEventListener(MouseEvent.ROLL_OUT,onListRollOutHandler);
							listArr.push(childList);
						}else{
							childList = listArr[indexList];
						}	
						
						childList.dataProvider = listchidlitem.childs;
						
						childList.x =list.listWidth+list.x;
						childList.y = teee.y;
						childList.upDisplayList();
						
						childList.visible =true;
						this.addChild(childList);	
						
						
						childList.setMaxHeight(component.contentContainer.height);
						
						var rect:LocationRect = Utils.getBounds(childList);
						
						if(rect.buttom<0){							
							
							childList.y+=childList.y+rect.buttom;
						}
						rect = Utils.getBounds(childList);
						if(rect.right<0){
							//childList.x += rect.right; 
						}
						
						
						for(var yy:int=indexList+1;yy<listArr.length;yy++){
							list = listArr[yy];
							if(list){
								if(list.parent){
									list.parent.removeChild(list);
								}						
								//list.removeFromStage();
							}
						}
						
						listArr.splice(indexList+1,listArr.length);
						
					}else{
						isExtChild =false;
						removeListFormList(list);
					}
				}else{
					isExtChild =false;
					removeListFormList(list);		
				}				
				
			}
			
		}
		private function removeListFormList(list:List):void{
			if(list){
				
				this.indexList = int(list.name);
				
				if(indexList==0){
					//return;
				}
				
				if(int(list.name)!=indexList){
					list = listArr[indexList];
					if(list){
						if(list.parent){
							list.parent.removeChild(list);
						}
						//list.removeFromStage();
					}						
				}
				for(var i:int=indexList+1;i<listArr.length;i++){
					list = listArr[i];
					if(list){
						if(list.parent){
							list.parent.removeChild(list);
						}		
						//list.removeFromStage();
					}
				}
				
				listArr.splice(indexList+1,listArr.length);
			}
		}
		private function onListRollOutHandler(event:MouseEvent):void
		{
			var list:List = event.target as List;
			
			if(!isExtChild){
				list.name = String(int(list.name)-1)
				removeListFormList(list);
			}
			
		}
		
		protected function onChidlListItemChangeHandler(event:ControlEvent):void
		{
			
			_childList = event.target as List;	
			
			var evt:ControlEvent = new ControlEvent(ControlEvent.CHANGE,_childList.currentItem.data);	
			this.dispatchEvent(evt);			
		}	
		
		override public function createUI():void
		{
			super.createUI();			
			
			//this.updateUI();
			//Log.out("a");
		}	
		
		protected function onChangeHandler(event:ControlEvent):void
		{			
			onChidlListItemChangeHandler(event);
		}		
		
		override public function updateUI():void
		{
			//Log.out("b");
			this.cleanUp();
			
			this.indexList =0;	
			
			
			
			
			if(_maxHeight==-1){
				_maxHeight=component.contentContainer.height;	
			}else{
				if(_maxHeight>component.contentContainer.height){
					_maxHeight=component.contentContainer.height;	
				}				
			}
			
			parnList.setMaxHeight(_maxHeight);
			
			
			
			
			
			parnList.dataProvider = _dataProvider;
			
			this.addChild(parnList);
			
			parnList.upDisplayList();
			
			
			parnList.ItemCellRender = _itemCellRenaderer;
			parnList.column= indexList;		
			parnList.name = String(indexList);			
			
			
			
			listArr.push(parnList);
			
			//Log.out(parnList.width,parnList.height,"listchild parent List");
			
			var rect:LocationRect = Utils.getBounds(parnList);
			
			//Log.out(rect);
			
			if(rect.buttom<0){
				var te:Number = _maxHeight+rect.buttom-30;
				if(te<30){
					te=30;
				}
				parnList.setMaxHeight(te);
			}			
			
			
			this._childList = parnList;
		}
		
		protected function onChildListItemSelectHandler(event:ControlEvent):void
		{
			_childList = event.target as List;
			//evt = new ControlEvent(ControlEvent.ITEM_SELECT,_childList.currentItem);			
			//this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_SELECT,_childList.currentItem));	
			this.dispatchEvent(new ControlEvent(ControlEvent.ITEM_SELECT,event.data));	
		}		
		
	}
	
}
