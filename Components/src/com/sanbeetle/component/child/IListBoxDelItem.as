package com.sanbeetle.component.child
{
	import com.sanbeetle.interfaces.IFListItem;
	import com.sanbeetle.skin.IListBoxItemBg;
	import com.sanbeetle.skin.image.DelIco;
	
	import flash.display.Bitmap;
	
	/**
	 *
	 *@author sixf
	 */
	public class IListBoxDelItem extends IListBoxItem
	{
		private var delIcon:DelIco;
		public function IListBoxDelItem()
		{
			super();
			
			delIcon = new DelIco();
			this.addChild(new Bitmap(delIcon));
		}
		
		override protected function get ItemBg():IListBoxItemBg
		{
			var item:IListBoxDelItemBg=new IListBoxDelItemBg();
			
			return item;
		}
		
		override protected function itemColor(value:IFListItem):String
		{
			
			return "0xffffff";
		}
		
		override protected function itemOverColor(value:IFListItem):String
		{
			
			return "0xffffff";
		}
		
		
	}
}