package com.game.framework.net {
	import com.game.framework.ifaces.IURL;
	
	import flash.events.Event;
	
	/**
	 *
	 *@author sixf
	 */
	public class SkinLoader extends AssetItem {
		public function SkinLoader(url:IURL, currentDomain:Boolean = true) {
			super(url, currentDomain);
		}
		
		override public function dispose():void
		{	
			if(this.contentLoaderInfo.content){
				trace(this.contentLoaderInfo.content.root);
				this.contentLoaderInfo.content.dispatchEvent(new Event("view_dispose"));
			}
			super.dispose();
		}
		
	}
}