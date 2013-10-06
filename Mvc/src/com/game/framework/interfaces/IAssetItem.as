package com.game.framework.interfaces
{
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	
	/**
	 * 加载对象的接口，定义了一些公共的方法
	 * @author sixf
	 */
	public interface IAssetItem
	{
		
		
		/**
		 *  
		 * @return 
		 * 
		 */
		function get type():String;
		/**
		 * url=MediaURL.fromUIView(MediaURL.SKIN.LoginViewSkin) 
		 * 这个就是加载对象要加载的路径 或 URL
		 * @return 
		 * 
		 */
		function get url():IURL;		
		function set url(value:IURL):void;
		/**
		 * 返回 加载对象的内容，可能是 字符，可能是 资源 
		 * @return 
		 * 
		 */
		function get content():Object;
		/**
		 * 与显示对象有关的加载时，有这个信息 
		 * @return 
		 * 
		 */
		function get contentLoaderInfo():LoaderInfo;
		/**
		 * 加载对象的执行回调的接口 
		 * @return 
		 * 
		 */
		function get getDatainterface():IAssetsData;
		/**
		 * 设置回调接口，如<br/>
		 * var hud:MediaAssetItem =uimanager.addMediaView(new MediaAssetItem(MediaURL.fromUIView(MediaURL.SKIN.HUDViewSkin)));	<br/>	
		  <b>hud.setDatainterface =this;</b><br/>
		   hud.initView(); <br/>
		   * 必须 在  initView 方法之前被设置
		 * @param value
		 * 
		 */
		function set setDatainterface(value:IAssetsData):void;	
		/**
		 * 初始化UI界面
		 * @param type 消息类型
		 * @param notify 初始时要发送的信息
		 * 
		 */	
		function initView(type:String=null,notify:INotifyData=null):void;
		/**
		 * 释放资源 
		 * 
		 */
		function dispose():void;
		
		/**
		 * 资源加载完成
		 * @param event
		 * 
		 */
		function onCompleteHandler(event:Event):void;
		/**
		 * 资源加载进度 
		 * @param event
		 * 
		 */
		function onProgressHandler(event:ProgressEvent):void;
		/**
		 * 加载时，发生错误 
		 * @param event
		 * 
		 */
		function onIOErrorHandler(event:IOErrorEvent):void;
	}
}