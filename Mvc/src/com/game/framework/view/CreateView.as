package com.game.framework.view
{
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.interfaces.ICreateView;
	import com.game.framework.interfaces.IURL;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	[Event(name="complete_load",type="com.game.framework.events.AssetsEvent")]
	/**
	 *
	 *@author sixf
	 */
	public class CreateView extends BaseView implements ICreateView
	{
		protected var viewLoader:Loader;
		private var childName:Vector.<String>;	
		private var viewURL:IURL;
		
		public function CreateView(viewURL:IURL)
		{
			super();			
			this.viewURL = viewURL;	
			
		}
		override public function loadSkin():ICreateView{
			
			viewLoader = new Loader();
			viewLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			viewLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			viewLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			viewLoader.contentLoaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			//viewLoader.load(new URLRequest(viewURL),new LoaderContext(false,ApplicationDomain.currentDomain));
			viewLoader.load(new URLRequest(viewURL.url),new LoaderContext(false,ApplicationDomain.currentDomain));
			return this;
		}		
		private function onIOErrorHandler(event:IOErrorEvent):void
		{
			trace(event.toString());
		}
		private function uncaughtErrorHandler(event:UncaughtErrorEvent):void
		{
			if (event.error is Error)
			{
				var error:Error = event.error as Error;
				trace(error.getStackTrace());
				// do something with the error
			}
			else if (event.error is ErrorEvent)
			{
				var errorEvent:ErrorEvent = event.error as ErrorEvent;
				// do something with the error
				trace(errorEvent.toString());
			}
			else
			{
				trace(event.toString());
				// a non-Error, non-ErrorEvent type was thrown and uncaught
			}
		}
		/**
		 * viewLoader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
		 * @param name
		 * @return 
		 * 
		 */
		protected function getAssetClassByName(name:String):Class
		{
			return viewLoader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
		}	
		protected function onProgressHandler(event:ProgressEvent):void
		{
			
		}		
		private function onCompleteHandler(event:Event):void
		{
			childName = viewLoader.contentLoaderInfo.applicationDomain.getQualifiedDefinitionNames();	
			
			content = viewLoader.content as DisplayObjectContainer;
			
			init(MovieClip(content));
			
			this.dispatchEvent(new AssetsEvent(AssetsEvent.COMPLETE_LOAD));
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			viewLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onCompleteHandler);
			viewLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			viewLoader.contentLoaderInfo.uncaughtErrorEvents.removeEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtErrorHandler);
			
			this.removeChildren();
			/*while(this.numChildren>0){
				this.removeChildAt(0);
			}*/
			
			viewLoader.unloadAndStop();
					
			childName.splice(0,childName.length);			
			
			if(this.parent!=null){				
				this.parent.removeChild(this);
			}			
			viewLoader=null;			
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
		protected function getAssetByName(name:String):Object{
			var Asset:Class = viewLoader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
			return new Asset();
		}
		/**
		 *皮肤资源加载完，初始化界面元素。
		 *  
		 * @param content
		 * 
		 */
		protected function init(content:MovieClip):void{
			throw new Error("请重写init 方法！目标："+this.toString());
		}
		/**
		 * 获取资源里的子项内容列表
		 * @return 
		 * 
		 */
		protected function get getChildName():Vector.<String>{
			if(childName==null){
				childName =new Vector.<String>;
				trace("getChildName 属性必须 在init 之后调用！");
			}
			return childName;
		}
		
	}
}