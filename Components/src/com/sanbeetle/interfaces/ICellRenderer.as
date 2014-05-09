package com.sanbeetle.interfaces
{
	import com.sanbeetle.core.DisplayItem;
	import com.sanbeetle.data.ListData;

	public interface ICellRenderer 
	{
		function getItem():DisplayItem;
		function createItem(itemData:IFListItem,listData:ListData):DisplayItem;
		function upData(itemData:IFListItem,listData:ListData):void;
		
		
		//function get itemHeight():int;	
		//function get itemWidth():int;
		

		
		/*
		data : Object
		获取或设置一个 Object，该 Object 表示与组件关联的数据。
		ICellRenderer
		listData : ListData
		获取或设置应用到单元格的列表属性，例如 index 和 selected 值。
		ICellRenderer
		selected : Boolean
		获取或设置一个布尔值，该值指示是否已选择当前单元格。
		ICellRenderer
		x : Number
		[只写] 设置单元格渲染器的 x 坐标
		ICellRenderer
		y : Number
		[只写] 设置单元格渲染器的 y 坐标*/
	}
}