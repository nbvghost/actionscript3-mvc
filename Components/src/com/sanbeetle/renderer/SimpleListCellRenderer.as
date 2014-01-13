package com.sanbeetle.renderer
{
	import com.sanbeetle.component.child.IListBoxItem;
	import com.sanbeetle.core.DisplayItem;
	import com.sanbeetle.data.ListData;
	import com.sanbeetle.interfaces.ICellRenderer;
	import com.sanbeetle.interfaces.IFListItem;
	
	public class SimpleListCellRenderer implements ICellRenderer
	{
		
		
		protected var item:DisplayItem;
		public function SimpleListCellRenderer()
		{
			
		}		
		public function upData(itemData:IFListItem, listData:ListData):void
		{			
			item.listData =listData;			
			item.data = data(itemData);				
			
		}	
		
		public function get haveStage():Boolean
		{			
			return item.haveStage;
		}
		
		public function setStage(value:Boolean):void
		{			
			item.setStage(value);
		}		
		public function createItem(itemData:IFListItem, listData:ListData):DisplayItem
		{
			
			item = new IListBoxItem();
			
			item.listData =listData;	
			item.data = data(itemData);
			
			return item;
		}
		
		public function getItem():DisplayItem{			
						
			return item;
		}
		protected function  data(itemData:IFListItem):IFListItem{
			
			itemData.itemColor = "0xffffff";
			itemData.itemOverColor = "0xffffff";
			
			return itemData;
		}
	}
}