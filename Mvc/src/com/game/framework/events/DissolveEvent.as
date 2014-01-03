package com.game.framework.events
{
	import com.game.framework.net.MediaAssetItem;
	
	import flash.events.Event;
	
	/**
	 * 消息事件  
	 * @author sixf
	 * 
	 */
	public class DissolveEvent extends Event
	{
		public static const DISSOLVE:String="dissolve";
		private var _mediaAssetItem:MediaAssetItem;
		
		/**
		 * 消息事件 
		 * @param type
		 * @param _mediaAssetItem
		 * 
		 */
		public function DissolveEvent(type:String,_mediaAssetItem:MediaAssetItem=null)
		{
			super(type);
			this._mediaAssetItem =_mediaAssetItem;
		}

		public function get mediaAssetItem():MediaAssetItem
		{
			return _mediaAssetItem;
		}

		public function set mediaAssetItem(value:MediaAssetItem):void
		{
			_mediaAssetItem = value;
		}

	}
}