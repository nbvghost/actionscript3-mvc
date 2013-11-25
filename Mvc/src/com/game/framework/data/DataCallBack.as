package  com.game.framework.data {
	import com.game.framework.ifaces.ICallBack;
	
	public class DataCallBack implements ICallBack {

		public function get progressHandler():Function
		{
			return _progressHandler;
		}

		public function set progressHandler(value:Function):void
		{
			_progressHandler = value;
		}

		public function get errorHandler():Function
		{
			return _errorHandler;
		}

		public function set errorHandler(value:Function):void
		{
			_errorHandler = value;
		}

		public function get successHandler():Function
		{
			return _successHandler;
		}

		public function set successHandler(value:Function):void
		{
			_successHandler = value;
		}

		private var _successHandler:Function;
		private var _errorHandler:Function;
		private var _progressHandler:Function;
		
		public function DataCallBack(success:Function=null, error:Function=null, progress:Function = null) {
			this.successHandler = success;
			this.errorHandler = error;
			this.progressHandler = progress;
			
		}
		
		public function success(data:Object, action:int):void {
			if (successHandler.length == 2) {
				successHandler.call(this, data, action);
			} else {
				throw new Error("参数不匹配");
			}
		}
		
		public function progress(action:int):void {
			if (progressHandler == null) {
				return;
			}
			if (progressHandler.length == 1) {
				progressHandler.call(this, action);
			} else {
				throw new Error("参数不匹配");
			}
		}
		
		public function error(data:Object, action:int):void {
			if (errorHandler.length == 2) {
				errorHandler.call(this, data, action);
			} else {
				throw new Error("参数不匹配");
			}
		}
	}
}