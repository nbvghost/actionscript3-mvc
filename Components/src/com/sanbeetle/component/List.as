package com.sanbeetle.component
{
	
	import com.asvital.dev.Log;
	import com.sanbeetle.component.child.IListBox;
	import com.sanbeetle.events.ControlEvent;
	import com.sanbeetle.model.LocationRect;
	import com.sanbeetle.skin.IListBoxBg;
	
	/**
	 * 
	 * 项发生改变时
	 * 
	 */	
	[Event(name="change",type="com.sanbeetle.events.ControlEvent")]	
	/**
	 * 鼠标滑过项时 
	 */	
	[Event(name="item_over",type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 * 鼠标移出项时 
	 */	
	[Event(name="item_out",type="com.sanbeetle.events.ControlEvent")]
	
	/**
	 * 项里面的内容 的事件 
	 */	
	[Event(name="item_renderer_select",type="com.sanbeetle.events.ControlEvent")]
	
	public class List extends IListBox 
	{
		
		
		private var ivbar:IVScrollBar;	
		
		private var _list:IListBox;
		
		private var _padding:LocationRect;
		
		private var bg:IListBoxBg;
		
		private var _maxHeight:int = -1;
		
		
		private var _listWidth:int = 0;
		private var _listHeight:int = 0;
		/**
		 *  这个有滚动条而以
		 * 
		 */
		public function List(parentList:List=null){
			
			super(parentList);
			bg = new IListBoxBg();
			
			ivbar = new IVScrollBar;
			
			//_maxHeight = this.component.getMaxListHeight();
			
			this.addChild(bg);		
			this.addChild(content);
			this.addChild(ivbar);
			
			
			ivbar.source = this.content;
			
			_padding = new LocationRect(9,1,9,1);
			
			//_padding.right =_padding.left;	
		}		
		
		public function get listHeight():int
		{
			return _listHeight;
		}
		
		public function get listWidth():int
		{
			return _listWidth;
		}
		
		override public function upDisplayList():void
		{
			// TODO Auto Generated method stub
			super.upDisplayList();
			
			if(ivbar){
				ivbar.upDisplayList();
			}
			
		}
		
		
		
		public function setMaxHeight(h:int=-1):void{
			if(_maxHeight!=h){
				_maxHeight = h;
				this.updateUI();				
			}
			if(ivbar){
				ivbar.upDisplayList();
			}
		}
		public function get padding():LocationRect
		{
			return _padding;
		}
		
		public function set padding(value:LocationRect):void
		{
			_padding = value;
		}
		
		/*	override public function createUI():void
		{
		
		
		updateUI();
		}	*/
		
		override public function get height():Number
		{
			// TODO Auto Generated method stub
			return bg.height;
		}
		
		override public function get width():Number
		{
			// TODO Auto Generated method stub
			return bg.width;
		}
		
		
		override public function set height(value:Number):void
		{
			Log.error("对 List height 设置无效");
		}
		
		override protected function onAddStage():void
		{
			// TODO Auto Generated method stub
			super.onAddStage();
			
			
		}
		
		override protected function onRemoveStage():void
		{
			// TODO Auto Generated method stub
			super.onRemoveStage();
		}
		
		
		override protected function updateUI():void
		{	
			
			
			super.updateUI();
			
			
			//var rect:LocationRect = Utils.getBounds(this);
			
			ivbar.y = _padding.top;
			//ivbar.x = _padding.left;
			
			//ivbar.height = this.content.height-_padding.top-_padding.buttom;
			ivbar.height = this.content.height;
			
			if(_maxHeight!=-1){
				//this.setMinWidth(
				if(_maxHeight>content.height){
					this.setMinWidth(this.getMinWidth());
					//ivbar.height = content.height-_padding.top-_padding.buttom;
					ivbar.height = Math.round(content.height);
				}else{
					
					ivbar.height = Math.round(_maxHeight-_padding.top-_padding.buttom);				
					
				}
				
			}
			
			//ivbar.height = 50;
			
			ivbar.x = content.width+_padding.left;			
			
			
			//ivbar.height = _maxHeight-_padding.top-_padding.buttom;
			
			this.setChildIndex(ivbar,0);
			this.setChildIndex(this.content,0);
			this.setChildIndex(bg,0);
			
			
			
			
			ivbar.upDisplayList();
			
			if(ivbar.contentHeight>ivbar.height){
				
				bg.bg.width = content.width+_padding.left+_padding.right+15;
				bg.bg.height = ivbar.height+_padding.top+_padding.buttom;
				
			}else{
				
				//bg.bg.width = content.width+_padding.right+_padding.left;
				bg.bg.width = content.width+_padding.right;
				bg.bg.height = content.height+_padding.top+_padding.buttom;
			}
			
			this.drawBorder(bg.bg.width,bg.bg.height);
			
			_listHeight = bg.bg.height;
			_listWidth = bg.bg.width;
			
			
			
			
		}
		
		
	}
}