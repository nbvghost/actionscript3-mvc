package com.game.framework.net
{
	import com.game.framework.Launcher;
	import com.game.framework.error.OperateError;
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.interfaces.INotifyData;
	import com.game.framework.interfaces.ISwfFile;
	import com.game.framework.interfaces.IURL;
	import com.game.framework.logic.AssetsData;
	import com.game.framework.model.NotifyData;
	import com.game.framework.view.Mediator;
	
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * 仅用于模块的加载
	 * 使用 MediaAssetItem 对象方法:<br/>
	 * 1, addMediaView 先加到显示列表中，此时就可以得到父级，同时去判断父级中是否有相同名字（name）的对象，如果有，直接返回。<br/>
	 * 2，initView 初始化<br/>
	 * var login:MediaAssetItem = new MediaAssetItem(MediaURL.fromUIView(MediaURL.SKIN.LoginViewSkin));<br/>
	 * uimanager.addMediaView(login);<br/>
	 * login.initView();<br/>
	 * @author sixf
	 */
	public class MediaAssetItem extends AssetItem
	{
		
		private var mediator:Mediator;
		private var notify:NotifyData=null;
		private var notifyType:String=null;
		private var _isLoadSuccess:Boolean=false;
		/**
		 * 建设使用 uimanager.addMediaView(new MediaAssetItem(MediaURL.fromUIView(MediaURL.SKIN.HUDViewSkin)));	而不直接进行实例化 
		 * @param url
		 * 
		 */
		public function MediaAssetItem(url:IURL,currentDomain:Boolean=true)
		{
			super(url,currentDomain);				
		}	

		/**
		 *内部的资源是否加载完成,不统计其内部其它线程的加载
		 */
		public function get isLoadSuccess():Boolean
		{
			return _isLoadSuccess;
		}
		override public function onCompleteHandler(event:Event):void
		{			
			var swf:ISwfFile =content as ISwfFile;
			if(swf==null){
				throw new OperateError("loader.content 不是 ISwfFile 对象，这可能是加载的路径出错，请查看 MediaAssetItem 传入的 IURL 对象！地址："+contentLoaderInfo.url,this);
			}
			mediator = swf.getMediator;			
			Launcher.launcher.registerMediator(mediator);	
			
			this.getDatainterface.asssetComplete(this);
			this.addChild(mediator.view as DisplayObject);
			
			mediator.view.addEventListener(AssetsEvent.COMPLETE_LOAD,onSkinLoadCompleteHandler);
			mediator.view.loadSkin();
			
			_isLoadSuccess =true;
			
		}
		private function onSkinLoadCompleteHandler(e:AssetsEvent):void{
			mediator.view.removeEventListener(AssetsEvent.COMPLETE_LOAD,onSkinLoadCompleteHandler);
			this.getDatainterface.asssetAllComplete(this);
			
			mediator.handerNotify(Mediator.INIT_TYPE,Mediator.INIT_NOTIFY);
			if(notifyType!=Mediator.RE_INIT_TYPE){
				if(notifyType!=null){
					mediator.handerNotify(notifyType,notify);
				}
				
			}
			this.notifyType = null;
			this.notify = null;
		}
		/**
		 * 初始时，也就是执行一个资源的加载，此时可以向  Mediator 层发信息,加载到当前域中
		 * @param type 如果为 null 将使用 Mediator 中的 Mediator.DEFAULT_TYPE
		 * @param notify
		 * @see com.game.framework.view.Mediator.DEFAULT_TYPE
		 * @see com.game.framework.view.Mediator.DEFAULT_NOTIFY
		 * @see com.game.framework.interfaces.INotifyData
		 * @see com.game.framework.model.NotifyData
		 * @see com.game.framework.view.Mediator
		 */
		override public function initView(type:String=null,notify:INotifyData=null):void
		{		
			this.notifyType = type;
			this.notify = notify as NotifyData;
			
			if(this.notify==null){
				notify =Mediator.RE_INIT_NOTIFY;
			}
			if(this.notifyType==null){
				this.notifyType = Mediator.RE_INIT_TYPE;
			}
			
			if(_isinitView){
				mediator.handerNotify(Mediator.RE_INIT_TYPE,Mediator.RE_INIT_NOTIFY);
				if(notifyType!=Mediator.RE_INIT_TYPE){
					mediator.handerNotify(notifyType,notify);
				}		
				this.notifyType = null;
				this.notify = null;
				this.getDatainterface.asssetComplete(this);
				return;
			}
			_isinitView=true;
			if(this.parent==null){
				throw new OperateError("先添加到显示列表中，UIManager.addMediaView(MediaAssetItem) 加载的地址："+this.url.url,this);
				return;
			}
			//如果资源没有衩释放，将不重新加载
			if(_isLoadSuccess==true){
				return;
			}
			if(this.getDatainterface==null){
				this.setDatainterface=new AssetsData();
			}
			
			super.initView();			
			
		}
		
		/**
		 * 释放资源并移除 事件
		 * 
		 */
		override public function dispose():void
		{			
			super.dispose();
			
			
			mediator.dispose();		
			
			_isLoadSuccess = false;			
			_isinitView=false;
		}
		
		
	}
}