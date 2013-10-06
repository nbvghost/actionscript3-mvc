package com.game.framework.logic
{
	import com.game.framework.interfaces.IAssetItem;
	import com.game.framework.interfaces.IAssetsData;
	
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	/**
	 *
	 *@author sixf
	 */
	public class AssetsData implements IAssetsData
	{
		private var _asssetComplete:Function;
		private var _netError:Function;
		private var _progress:Function;
		private var _asssetAllComplete:Function;		
		
		
		/**
		 * 
		 * @param asssetAllCompleteFunc
		 * @param asssetCompleteFunc
		 * @param netErrorFunc
		 * @param progressFunc
		 * 
		 */
		public function AssetsData(asssetAllCompleteFunc:Function=null,asssetCompleteFunc:Function=null,netErrorFunc:Function=null,progressFunc:Function=null)
		{
			
			_asssetComplete=asssetCompleteFunc;
			
			_netError = netErrorFunc;
			
			_progress = progressFunc;
			
			_asssetAllComplete =asssetAllCompleteFunc;
		}
		public function get progressFunc():Function
		{
			return _progress;
		}
		
		public function set progressFunc(value:Function):void
		{
			_progress = value;
		}
		
		public function get netErrorFunc():Function
		{
			return _netError;
		}
		
		public function set netErrorFunc(value:Function):void
		{
			_netError = value;
		}
		
		public function get asssetCompleteFunc():Function
		{
			return _asssetComplete;
		}
		
		public function set asssetCompleteFunc(value:Function):void
		{
			_asssetComplete = value;
		}
		
		public function asssetAllComplete(data:IAssetItem):void
		{
			if(_asssetAllComplete!=null){
				_asssetAllComplete.call(this,data);
			}
			
		}
		public function asssetComplete(data:IAssetItem):void
		{
			if(_asssetComplete!=null){
				_asssetComplete.call(this,data);
			}
		}
		
		public function netError(event:IOErrorEvent, data:IAssetItem):void
		{
			if(_netError!=null){
				_netError.call(this,event,data);
			}
		}		
		public function progress(event:ProgressEvent, data:IAssetItem):void
		{
			if(_progress!=null){
				_progress.call(this,event,data);
			}
		}
	}
}