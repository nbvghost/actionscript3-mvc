package com.game.framework.views {
	import com.game.framework.FW;
	import com.game.framework.Launcher;
	import com.game.framework.base.BaseNotify;
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.ifaces.IMediator;
	import com.game.framework.ifaces.IObtain;
	import com.game.framework.ifaces.IProxy;
	import com.game.framework.ifaces.IRander;
	import com.game.framework.ifaces.IResourceManager;
	import com.game.framework.ifaces.IUIManager;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	/**
	 *
	 *@author sixf
	 */
	
	public class BaseMediator extends BaseNotify implements IMediator,IObtain,IRander{
		use namespace FW;
		
		private var _view:CreateView;
		protected var _uimanager:IUIManager;
		private var _resourceManager:IResourceManager;
		
		
		public function BaseMediator() {
			
		}
		
		public function enterFrame(e:Event):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function reSize(e:Event):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function timerRun(event:TimerEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		
		public function get uimanager():IUIManager
		{
			return _uimanager;
		}

		public function obtainMediator(mediatroName:String):Mediator {
			return Launcher.FW::launcher.obtainMediator(mediatroName);
		}
		
		public function obtainProxy(proxyName:String):IProxy {
			return Launcher.FW::launcher.obtainProxy(proxyName);
		}
		
		protected function get resourceManager():IResourceManager {
			
			return _resourceManager;// launcher.resourceManager;
		}
		/**
		 * 皮肤资源加载完成，并已经初始化完成
		 * @param event com.game.framework.events.AssetsEvent
		 * @see com.game.framework.events.AssetsEvent
		 */
		protected function viewDrawed(value:CreateView):void {
			//throw new Error("请重写 viewDrawed ! 目标："+this);
		}
		/**
		 * 视图
		 * @return
		 *
		 */
		public function get view():CreateView {
			return _view;
		}
		FW function initMediator(uimanager:IUIManager, resourceManager:IResourceManager):void {
			
			_uimanager = uimanager;
			this._resourceManager = resourceManager;
			
			if (_view) {
				_view.FW::uimanager = uimanager;
				_view.FW::resourceManager = resourceManager;
			}else{
				viewDrawed(null);
			}
			
		}		
		FW function set view(value:CreateView):void {
			_view = value;
			_view.addEventListener(AssetsEvent.COMPLETE_LOAD, onViewCompleteHandler);
		}
		protected function onViewCompleteHandler(event:AssetsEvent):void{
			
		}
		public function loadPicture():void {
			
		}
		
		public function dispose():void {
			if (_view) {
				if(this.uimanager){				
					uimanager.removeEnterFrame(_view);
					uimanager.removeReSize(_view);
					uimanager.removeTimerRun(_view);
				}
				_view.dispose();
				_view = null;
			}
			_uimanager = null;
			Launcher.FW::launcher.unregisterMediator(this);
		}
	}
}


