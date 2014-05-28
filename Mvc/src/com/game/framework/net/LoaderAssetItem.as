package com.game.framework.net {
	import com.game.framework.ifaces.IURL;
	
	/**
	 * 类似于Loader
	 *@author sixf
	 */
	public class LoaderAssetItem extends AssetItem {
		public function LoaderAssetItem(url:IURL, loadType:String = LoadType.CurrentApplicationDomain) {
			super(url, loadType);
		}
		
		
	}
}