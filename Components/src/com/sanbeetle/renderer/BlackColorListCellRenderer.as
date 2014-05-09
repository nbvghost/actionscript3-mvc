package com.sanbeetle.renderer
{
	import com.sanbeetle.interfaces.IFListItem;

	public class BlackColorListCellRenderer extends SimpleListCellRenderer
	{
		public function BlackColorListCellRenderer()
		{
			super();
		}
		
		override protected function data(itemData:IFListItem):IFListItem
		{
			itemData.itemColor ="0x333333";
			itemData.itemOverColor ="0xffffff";
			
			return itemData;
		}
		
		
	}
}