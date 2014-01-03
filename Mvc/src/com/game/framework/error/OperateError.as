package com.game.framework.error {
	import com.asvital.dev.Log;

	/**
	 * 自定义 try 报错
	 *@author sixf
	 */
	public class OperateError extends Error {
	
		
		public function OperateError(message:* = "", target:Object = null, id:* = 0) {
			if (target != null) {
				message = message + " 目标：" + target;
			}
			Log.out(id);
			super(message, id);
			
		}
		
		public function toString():String {
			return message+" errorType:"+this.errorID;
		}
	}
}