package com.sanbeetle.data
{
	
	
	
	
	/**
	 *
	 *@author sixf
	 */
	dynamic public class AttributeSimpleItem extends SimpleCollectionItem
	{
		
		public function AttributeSimpleItem(label:String=null, data:String=null,itemColor:String=null,enable:Boolean=true)
		{
			super(label, data);
			this.itemColor = itemColor;
			this.enable = enable;
			
		}
	}
}