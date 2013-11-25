package com.game.framework.ifaces {
	public interface ICallBack {
		function success(data:Object, action:int):void;
		
		function error(data:Object, action:int):void;
		
		function progress(action:int):void;
	}
}