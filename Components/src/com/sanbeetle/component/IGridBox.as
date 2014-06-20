package com.sanbeetle.component
{
	import com.asvital.dev.Log;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.interfaces.IDisplayItem;
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.renderer.GridBoxItemRenderer;
	import com.sanbeetle.utils.Utils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	[Event(name="select", type="com.sanbeetle.events.ControlEvent")]
	/**
	 *  
	 * @author sixf
	 * 
	 */
	public class IGridBox extends UIComponent
	{
		private var items:Vector.<DisplayObject>=new Vector.<DisplayObject>();
		
		
		private var _dataArray:Vector.<IFListItem> = new Vector.<IFListItem>();
		
		private var content:Sprite;
		
		private var _lineHeight:int = 24;
		
		private var _lineBackgroundFix:Boolean=false;
		
		private var ivsb:IVScrollBar;
		
		private var _isFloat:Boolean = false;		
		
		private var backgroundCl:uint = 0x000000;	
		private var background_alpha:Number = 0.05;
		private var _itemRendererCell:Function;
		private var _ItemRenderer:Class;
		
		
		
		
		public function IGridBox()
		{
			super();
			content=new Sprite();
			content.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			content.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			content.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			this.addChild(content);
			
			ivsb = new IVScrollBar();
			//ivsb.isFloat = true;
			this.addChild(ivsb);
			
			ivsb.source = content;
			
			_ItemRenderer = GridBoxItemRenderer;
			
		}
		public function get itemRendererCell():Function
		{
			return _itemRendererCell;
		}
		
		public function set itemRendererCell(value:Function):void
		{
			_itemRendererCell = value;
		}
		
		/**
		 * 滚动条
		 * @return 
		 * 
		 */
		public function get VScrollBar():IVScrollBar{
			return ivsb;
		}
		/**
		 * 滚动条 滚动的对象 
		 * @return 
		 * 
		 */
		public function get contentContainer():Sprite{
			
			return content;
		}
		public function get ItemRenderer():Class
		{
			return _ItemRenderer;
		}
		
		public function set ItemRenderer(value:Class):void
		{
			if(_ItemRenderer!=value){
				_ItemRenderer = value;
				while(content.numChildren>0){
					content.removeChildAt(0);
				}
				items.splice(0,items.length);
			}
			
		}
		protected function onMouseDownHandler(event:MouseEvent):void
		{
			/*if(event.target is IDisplayItem){
			IDisplayItem(event.target).mouseDown(event);
			}*/
			var target:DisplayObject=Utils.isChildTypeof(IDisplayItem,content,event.target as DisplayObject);
			
			if(target){
				IDisplayItem(target).mouseOver(event);
				this.dispatchEvent(new ControlEvent(ControlEvent.SELECT,target,event));
			}
		}
		
		protected function onMouseOverHandler(event:MouseEvent):void
		{
			var target:DisplayObject=Utils.isChildTypeof(IDisplayItem,content,event.target as DisplayObject);
			
			if(target){
				IDisplayItem(target).mouseOver(event);
			}
		}
		
		protected function onMouseOutHandler(event:MouseEvent):void
		{
			/*if(event.target is IDisplayItem){
			IDisplayItem(event.target).mouseOut(event);
			}*/
			var target:DisplayObject=Utils.isChildTypeof(IDisplayItem,content,event.target as DisplayObject);
			
			if(target){
				IDisplayItem(target).mouseOver(event);
			}
		}
		/**
		 * 滚动条，是否要盖住，内容 
		 * @return 
		 * 
		 */		
		[Inspectable(defaultValue=false)]
		public function get isFloat():Boolean
		{
			return _isFloat;
		}
		
		public function set isFloat(value:Boolean):void
		{
			_isFloat = value;
			
			ivsb.isFloat = _isFloat;
			
			
		}
		
		override protected function updateUI():void
		{
			ivsb.x = trueWidth-ivsb.width;
			
			ivsb.height = trueHeight;
			
			var p:int = 0;
			
			if(content.height<trueHeight){
				p = trueHeight/lineHeight;
			}else{
				p = content.height/lineHeight;
			}
			content.graphics.clear();
			
			
			var itemw:Number = this.trueWidth;
			
			if(_isFloat){
				itemw=trueWidth;
			}else{
				itemw=trueWidth-ivsb.width;
			}
			
			for (var i:int = 0; i < p; i++) 
			{
				
				if(_lineBackgroundFix){					
					if((i)%2!=0){
						
						content.graphics.beginFill(backgroundCl,background_alpha);
						content.graphics.drawRect(0,lineHeight*i,itemw,lineHeight);
						
					}
				}else{
					if((i+1)%2!=0){
						
						content.graphics.beginFill(backgroundCl,background_alpha);
						content.graphics.drawRect(0,lineHeight*i,itemw,lineHeight);
						
					}
				}
				
			}
			
			content.graphics.endFill();
			
			ivsb.upDisplayList();
			
			drawBorder(trueWidth,trueHeight);
		}
		
		
		/**
		 * 每一条的背景，间隔留空的切换器
		 * @return 
		 * 
		 */		
		[Inspectable(defaultValue=false)]
		public function get lineBackgroundFix():Boolean
		{
			return _lineBackgroundFix;
		}
		public function set lineBackgroundFix(value:Boolean):void
		{
			_lineBackgroundFix = value;
		}
		/**
		 * 每行的高 
		 * @return 
		 * 
		 */		
		[Inspectable(defaultValue=24)]
		public function get lineHeight():int
		{
			return _lineHeight;
		}
		
		public function set lineHeight(value:int):void
		{
			if(_lineHeight != value){
				
				_lineHeight = value;
				updateUI();
			}
		}
		/**
		 * 每一行的数据 
		 * @return 
		 * @see com.sanbeetle.interfaces.IFListItem
		 */		
		public function get dataArray():Vector.<IFListItem>
		{
			return _dataArray;
		}
		
		override public function dispose():void
		{
			while(content.numChildren>0){
				content.removeChildAt(0);
			}
			if(content.parent){
				this.removeChild(content);
			}
			
			content.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutHandler);
			content.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			content.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			
			items.splice(0,items.length);
			_dataArray.splice(0,_dataArray.length);
			
		}
		
		
		override protected function createUI():void
		{
			ivsb.height = this.trueHeight;
			ivsb.x = this.trueWidth-ivsb.width;
			
			updateUI();
		}
		
		/**
		 * 理解成刷新 
		 * 
		 */		
		override public function upDisplayList():void{
			
			for (var i:int = 0; i < _dataArray.length; i++) 
			{
				
				var ite:DisplayObject = getItem(i);
				IDisplayItem(ite).data = _dataArray[i];		
				
				
				var itemw:Number = this.trueWidth;
				
				if(_isFloat){
					itemw=trueWidth;
				}else{
					itemw=trueWidth-ivsb.width;
				}
				
				IDisplayItem(ite).setSize(itemw,_lineHeight,false,i+1);				
				
				ite.y = IDisplayItem(ite).contentHeight*i;
				
				content.addChild(ite);
				
				if(_itemRendererCell!=null){
					if(_itemRendererCell.length<2){
						throw new Error("itemRendererCell 回调函数参数不对。应该有2个，ite:IDisplayItem,index:int");
					}else{						
						_itemRendererCell.apply(this,[ite,i]);
					}
				}
				
			}
			
			updateUI();
			
		}		
		public function set dataArray(value:Vector.<IFListItem>):void
		{
			if(_ItemRenderer==null){
				Log.error("IGridBox gridBoxClassLoader 不能为空！");
				return;
			}
			
			while(content.numChildren>0){
				content.removeChildAt(0);
			}
			//value = new Vector.<IFListItem>();
			
			content.graphics.clear();
			
			
			_dataArray = value;			
			
		}		
		[Deprecated(message="目前无效")]
		public function addItem(disobject:DisplayObject):void{
			//items.push(disobject);
		}
		/**
		 * 通过  dataArray 的索引号得到相关的 ItemRenderer
		 * @param index
		 * @return 
		 * 
		 */		
		public function getItem(index:int):DisplayObject{
			
			if(items.length-1<index){
				
				items[index] = new _ItemRenderer();
				
			}
			
			return items[index];
		}
		[Deprecated(message="目前无效")]
		public function removeItem(index:int):DisplayObject{
			
			return null;
		}
		
		
	}
}