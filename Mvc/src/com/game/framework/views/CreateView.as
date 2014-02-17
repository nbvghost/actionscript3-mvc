package com.game.framework.views {
	import com.asvital.dev.Log;
	import com.game.framework.FW;
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.ifaces.ICreateView;
	import com.game.framework.ifaces.IRander;
	import com.game.framework.ifaces.IResourceManager;
	import com.game.framework.ifaces.IUIManager;
	import com.game.framework.net.AssetItem;
	
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	
	[Event(name="complete_load", type="com.game.framework.events.AssetsEvent")]
	/**
	 * CreateView 改成。非显示对象（被 CreateView.containerContent 代替）。但一然实现了 IRander 接口
	 *@author sixf
	 */
	public class CreateView extends EventDispatcher implements ICreateView,IRander {
		
		private var childName:Vector.<String>;
		//private var _contentLoaderInfo:LoaderInfo;
		private var _uimanager:IUIManager;
		private var _resourceManager:IResourceManager;
		
		private var _mediator:Mediator;
		
		private var _contentContainer:AssetItem;
		private var _skinContainer:AssetItem;
		private var _hasLoad:Boolean = true;
		
		public function CreateView() {
			super();
		}
		
		public function timerRun(event:TimerEvent):void
		{
			// TODO Auto Generated method stub
			
		}
		
		/**
		 * CreateView 视图容器。 
		 * @return 
		 * 
		 */	
		public function get contentContainer():AssetItem
		{
			return _contentContainer;
		}
		FW function get skinContainer():AssetItem{
			return _skinContainer;
		}
		FW function setContentContainer(cc:AssetItem,skin:AssetItem,mediator:Mediator):void
		{
			_contentContainer = cc;	
			_skinContainer= skin;
			_mediator = mediator;
			
			//_contentContainer.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverHandler);
			
			childName = _contentContainer.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();
			
			initBefore(skin.contentLoaderInfo);
			init(MovieClip(skin.contentLoaderInfo.content));
			this.dispatchEvent(new AssetsEvent(AssetsEvent.COMPLETE_LOAD));
		}		
		public function enterFrame(e:Event):void
		{
			// TODO Auto Generated method stub
			
		}
		protected function get mediator():Mediator{
			return _mediator;
		}
		public function reSize(e:Event):void
		{
			// TODO Auto Generated method stub
			
		}		
		
		FW function set uimanager(value:IUIManager):void {
			_uimanager = value;
		}
		
		FW function set resourceManager(value:IResourceManager):void {
			_resourceManager = value;
		}
		
		public function get resourceManager():IResourceManager {
			// TODO Auto Generated method stub
			return this._resourceManager;
		}
		
		public function get uimanager():IUIManager {
			// TODO Auto Generated method stub
			return this._uimanager;
		}
		
		/**
		 * viewLoader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
		 * @param name
		 * @return
		 *
		 */
		protected function getAssetClassByName(name:String):Class {
			return _contentContainer.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
		}
		
		protected function onProgressHandler(event:ProgressEvent):void {
			
		}
		
		/**
		 * CreateView 是要必须进行 加载 的 View,所以 needToLoad 等于 true,如果不想加载 请使用 SpriteView
		 * @see com.game.framework.view.SpriteView
		 * @return
		 *
		 */
		public function get needToLoad():Boolean {
			// TODO Auto Generated method stub
			return true;
		}
		
		private function onCompleteHandler(event:Event):void {
			
		}
		/**
		 *  CreateView 改成 不是显示对象， CreateView 没有可视化的东西。但是可以调试事件。
		 * 
		 */	
		public function dispose():void {
			/* this.removeChildren();
			childName.splice(0, childName.length);
			
			
			
			if (this.parent != null) {
			this.parent.removeChild(this);
			}*/
			
			if (_uimanager!=null) 
			{
				_uimanager.removeEnterFrame(this);
				_uimanager.removeReSize(this);
				_uimanager.removeTimerRun(this);
			}
			if(_contentContainer){
				//_contentContainer.removeChildren();
				//_contentContainer.dispose();
			}
			
			if(childName){				
				childName.splice(0,childName.length);
			}
			
			this._mediator = null;
			_skinContainer = null;
			_contentContainer = null;
			_uimanager = null;
			_resourceManager = null;
			
		}
		
		/**
		 *获取资源实例<br/>
		 * var Asset:Class = viewLoader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
		 * <br/>
		 return new Asset();
		 * @param name
		 * @return 实例化后，返回
		 *
		 */
		protected function getAssetByName(name:String):Object {
			var Asset:Class = _contentContainer.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
			return new Asset();
		}
		
		/**
		 * 执行在 init 方法之前
		 * @param loaderinfo
		 *
		 */
		protected function initBefore(loaderinfo:LoaderInfo):void {
			
		}
		
		/**
		 *皮肤资源加载完，初始化界面元素。
		 *
		 * @param content
		 *
		 */
		protected function init(content:MovieClip):void {
			throw new Error("请重写init 方法！目标：" + this.toString());
			
		}
		/**
		 * 获取资源里的子项内容列表
		 * @return
		 *
		 */
		protected function get getChildName():Vector.<String> {
			if (childName == null) {
				childName = new Vector.<String>;
				Log.out("getChildName 属性必须 在init 之后调用！");
			}
			return childName;
		}
		
	}
}