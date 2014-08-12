package com.game.framework.net {
	import com.game.framework.ifaces.IURL;
	
	import flash.events.Event;
	import flash.system.LoaderContext;
	
	/**
	 *
	 *@author sixf
	 */
	public class SkinLoader extends AssetItem {
		public function SkinLoader(url:IURL, loadContext:LoaderContext,loadType:String = LoadType.CurrentApplicationDomain,contentType:String=LoadContentType.MEDIA_CONTENT) {
			super(url, loadType,contentType);
			
			if(loadContext!=null){
				this._loaderContext = loadContext;				
			}
		}
		
		override public function dispose():void
		{	
			if(this.contentLoaderInfo.content){
				//Log.out(this.contentLoaderInfo.content.root);
				this.contentLoaderInfo.content.dispatchEvent(new Event("view_dispose"));
			}
			super.dispose();
		}
		
	}
}