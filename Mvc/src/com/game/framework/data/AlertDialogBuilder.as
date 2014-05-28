package com.game.framework.data
{
	import com.asvital.dev.Log;
	import com.game.framework.enum.MaskBackGroundType;
	import com.game.framework.error.OperateError;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IURL;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="sideSelectIndexChange", type="com.game.framework.data.AlertDialogBuilder")]
	/**
	 * AlerDialog 描述对象
	 *@author sixf
	 */
	public class AlertDialogBuilder extends EventDispatcher
	{
		private var _titleData:DialogDataItem;
		private var _view:IURL;		
		private var _notify:INotifyData;		
		private var _width:int=0;
		private var _height:int=0;
		
		private var _diaLogButtons:Vector.<DialogButtonData> = new Vector.<DialogButtonData>();
		
		private var _sideBtnData:Vector.<DialogDataItem> = new Vector.<DialogDataItem>();
		
		private var _sideTabHeight:int=140;
		private var _isShadow:Boolean =true;
		private var _modal:Boolean =true;
		
		public static const sideSelectIndexChange:String="sideSelectIndexChange";
		
		private var _titleCenter:Boolean =true;
		
		private var _alertBorderType:String = AlertBorderType.DEFAULT;
		
		private var _sideSelectIndex:int = -1;
		
		private var _maskBackGroundType:int =MaskBackGroundType.DEFAUTL;
		
		public function AlertDialogBuilder()
		{
			_titleData = new DialogDataItem("undefined",null);
		}		
		
		public function get maskBackGroundType():int
		{
			return _maskBackGroundType;
		}

		public function set maskBackGroundType(value:int):void
		{
			_maskBackGroundType = value;
		}

		public function get alertBorderType():String
		{
			return _alertBorderType;
		}

		public function set alertBorderType(value:String):void
		{
			_alertBorderType = value;
		}

		[Bindable(event=sideSelectIndexChange)]
		/**
		 * 侧边按钮的选中 
		 */
		public function get sideSelectIndex():int
		{
			return _sideSelectIndex;
		}
		
		/**
		 * @private
		 */
		public function set sideSelectIndex(value:int):void
		{
			//if(_sideSelectIndex != value){
				_sideSelectIndex = value;
				if(_sideSelectIndex<0){
					Log.error("多个视图的弹出窗口，必须选中一个。 sideSelectIndex 属性不能为 -1。");
					_sideSelectIndex = 0;
				}
				dispatchEvent(new Event(sideSelectIndexChange));
			//}
		}
		
		public function set sideBtnData(value:Vector.<DialogDataItem>):void
		{
			if(value==null){
				throw new OperateError("sideBtnData 参数不能为 null",this);
			}
			_sideBtnData = value;
		}
		
		public function get titleData():DialogDataItem
		{
			
			return _titleData;
		}
		
		public function set titleData(value:DialogDataItem):void
		{		
			if(value!=null){
				_titleData.label = value.label;
				_titleData.view = value.view;
			}			
		}
		
		public function get titleCenter():Boolean
		{
			return _titleCenter;
		}
		
		public function set titleCenter(value:Boolean):void
		{
			_titleCenter = value;
		}
		
		/**
		 * 每个元素是 
		 * @return 
		 * 
		 */
		public function getDiaLogButtons():Vector.<DialogButtonData>
		{
			return _diaLogButtons;
		}
		
		/**
		 *  将两个 diaLogButtons 数组合并，生成 新的数据，不创建新的副本。 
		 * @param value
		 * 
		 */
		public function setDiaLogButtons(value:Vector.<DialogButtonData>):void
		{
			_diaLogButtons=_diaLogButtons.concat(value);
		}
		/**
		 * 窗口的高
		 * 不设置，程序处理 
		 * @return 
		 * 
		 */		
		public function get height():int
		{
			return _height;
		}
		
		public function set height(value:int):void
		{
			_height = value;
		}
		/**
		 * 窗口的宽
		 * 不设置，程序处理  
		 * @param value
		 * 
		 */
		public function get width():int
		{
			return _width;
		}
		
		public function set width(value:int):void
		{
			_width = value;
		}
		/**
		 * 调用者 设置，被调用者设置，无效 
		 * @return 
		 * 
		 */
		public function get view():IURL
		{
			return _view;
		}
		
		public function set view(value:IURL):void
		{
			_view = value;
		}
		/**
		 * 模态窗口 
		 * @return 
		 * 
		 */
		public function get modal():Boolean
		{
			return _modal;
		}
		
		public function set modal(value:Boolean):void
		{
			_modal = value;
		}
		/**
		 * 投影 
		 * @return 
		 * 
		 */
		public function get isShadow():Boolean
		{
			return _isShadow;
		}
		
		public function set isShadow(value:Boolean):void
		{
			_isShadow = value;
		}
		/**
		 * 当是有侧边按钮时，按钮的 高 
		 * @return 
		 * 
		 */
		public function get sideTabHeight():int
		{
			return _sideTabHeight;
		}
		
		public function set sideTabHeight(value:int):void
		{
			_sideTabHeight = value;
		}
		/**
		 * 侧边的切换，tab 标签 ，数据 
		 */
		public function get sideBtnData():Vector.<DialogDataItem>
		{
			return _sideBtnData;
		}	
		
		
		
		/**
		 * 传成被调用者的消息 
		 * @return 
		 * 
		 */		
		public function get notify():INotifyData
		{
			return _notify;
		}
		
		public function set notify(value:INotifyData):void
		{
			_notify = value;
		}
		
		/**
		 *  添加 一按钮
		 * @param buttonData
		 * @return 
		 * 
		 */
		public function setPositiveButton(buttonData:DialogButtonData):AlertDialogBuilder{
			buttonData.type = DialogButtonData.Positive;
			_diaLogButtons.push(buttonData);
			
			return this;
		}
		/**
		 *  添加 一按钮
		 * @param buttonData
		 * @return 
		 * 
		 */
		public function setNegativeButton(buttonData:DialogButtonData):AlertDialogBuilder{
			buttonData.type = DialogButtonData.Negative;
			_diaLogButtons.push(buttonData);			
			return this;
		}
	}
}