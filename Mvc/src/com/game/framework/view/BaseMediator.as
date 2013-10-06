package com.game.framework.view
{
	import com.game.framework.base.BaseNotify;
	import com.game.framework.interfaces.ICreateView;
	import com.game.framework.interfaces.IMediator;
	import com.game.framework.interfaces.IObtain;
	import com.game.framework.interfaces.IProxy;
	import com.game.framework.interfaces.IResourceManager;
	import com.game.framework.interfaces.IUIManager;

	/**
	 *
	 *@author sixf
	 */
	public class BaseMediator extends BaseNotify implements IMediator,IObtain
	{
		
		private var _view:ICreateView;
		protected var uimanager:IUIManager;	
		
		public function BaseMediator(view:ICreateView)
		{		
			this.view = view;			
		}		
		public function obtainMediator(mediatroName:String):Mediator
		{			
			return launcher.obtainMediator(mediatroName);
		}
		
		public function obtainProxy(proxyName:String):IProxy
		{			
			return launcher.obtainProxy(proxyName);
		}	
		protected function get resourceManager():IResourceManager{
			return launcher.resourceManager;
		}
		/**
		 * 视图 
		 * @return 
		 * 
		 */
		public function get view():ICreateView
		{
			return _view;
		}
		
		public function intiUIManager(uimanager:IUIManager):void
		{
			this.uimanager = uimanager;
			_view.uimanager = uimanager;
		}
		
		
		public function initMediator():void
		{
						
		}		
		
		public function set view(value:ICreateView):void
		{
			_view = value;
		}		
		public function loadPicture():void{
			
		}		
		public function dispose():void
		{
			if(_view){
				_view.dispose();
				_view=null;
			}			
			uimanager=null;		
			launcher.unregisterMediator(this);
		}			
	}
}


