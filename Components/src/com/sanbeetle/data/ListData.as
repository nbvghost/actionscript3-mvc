package com.sanbeetle.data
{
	import com.sanbeetle.interfaces.IFListItem;
	
	
	public class ListData extends Object
	{
		private var _column:uint = 0;
		private var _row:int = -1;	
		private var _data:IFListItem;
		private var _parentListData:ListData;
		
		
		/**
		 *  
		 * @param _label  
		 * @param _column 数据项目所在的列。
		 * @param _row 数据项目所在的行
		 * 
		 */
		public function ListData(_data:IFListItem,_column:uint,_row:int,parentList:ListData)
		{
			
			this._column = _column;
			this._data =_data;
			this._row = _row;	
			this._parentListData = parentList;
		}

		public function get parentListData():ListData
		{
			return _parentListData;
		}

		public function toString():String{
			
			return "data:"+data+",row:"+row+",column:"+column+",parentListData:"+_parentListData;
		}
		public function get data():IFListItem
		{
			return _data;
		}
		
		public function get row():uint
		{
			return _row;
		}
		
		public function get column():uint
		{
			return _column;
		}
		
	}
}