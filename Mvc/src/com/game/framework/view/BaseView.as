package com.game.framework.view
{
	import com.game.framework.display.UIComponent;
	import com.game.framework.interfaces.ICreateView;
	import com.game.framework.interfaces.IUIManager;
	
	import flash.display.DisplayObjectContainer;

	/**
	 *
	 *@author sixf
	 */
	public class BaseView extends UIComponent implements ICreateView
	{
		private var _uimanage:IUIManager;
		protected var content:DisplayObjectContainer;
		public function BaseView()
		{
			super();
		}		
		public function get uimanager():IUIManager
		{
			return _uimanage;
		}		
		public function set uimanager(value:IUIManager):void
		{
			_uimanage = value;
		}
		public function loadSkin():ICreateView{
		
			return this;
		}
		
		public function get hasLoad():Boolean
		{
			// TODO Auto Generated method stub
			return true;
		}
		
		public function set hasLoad(value:Boolean):void
		{
			
			
		}
		
		public function dispose():void
		{
			content=null;
			_uimanage=null;
			
		}
		
		
	}
}