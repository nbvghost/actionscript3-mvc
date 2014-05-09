package com.sanbeetle.data
{
	
	
	/**
	 *
	 *@author sixf
	 */
	public dynamic class ListChildItem extends SimpleCollectionItem
	{
		private var _childs:DataProvider;
		
		
		public function ListChildItem(label:String,data:Object)
		{
			super(label,data);
		}
		[Collection(collectionClass="com.sanbeetle.data.DataProvider", identifier="item", collectionItem="com.sanbeetle.data.SimpleCollectionItem")]
		/**
		 * 子菜单数据 
		 */
		public function get childs():DataProvider
		{
			return _childs;
		}

		/**
		 * @private
		 */
		public function set childs(value:DataProvider):void
		{
			
			_childs = value;
			
		}

	}
}