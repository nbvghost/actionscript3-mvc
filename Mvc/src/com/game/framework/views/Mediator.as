package com.game.framework.views {
	import com.asvital.debug.Console;
	import com.game.framework.FW;
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.error.OperateError;
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.ifaces.IDialogID;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.models.NotifyData;
	
	/**
	 * MediaAssetItem.intiView() 被执行将发送 （Mediator.DEFAULT_TYPE，DEFAULT_NOTIFY）消息。
	 * MVC 的 父级 ，要重写  viewDrawed 方法和 name 方法
	 * @see com.game.framework.net.MediaAssetItem#initView()
	 *@author sixf
	 */
	public class Mediator extends BaseMediator {		
		
		private var _notiys:Vector.<Object>;
		
		protected var isSkinLoad:Boolean = false;
		/**
		 * 默认 Mediator 又被初始化的消息类型,主要用于模块的初始化
		 */
		public static const RE_INIT_TYPE:String = "mediator_re_init_type";
		/**
		 * 默认 Mediator 又被初始化的消息
		 */
		public static const RE_INIT_NOTIFY:NotifyData = new NotifyData(RE_INIT_TYPE, "Mediator 又被 initView ！");
		
		/**
		 * 默认 Mediator 又被初始化的消息类型
		 */
		public static const INIT_TYPE:String = "mediator_init_type";
		/**
		 * 默认 Mediator 又被初始化的消息
		 */
		public static const INIT_NOTIFY:NotifyData = new NotifyData(INIT_TYPE, "Mediator 被 initView ！");
		
		/**
		 *  实例化时，传入 ICreateView 视图对象
		 * @param view
		 * @see com.game.framework.interfaces.ICreateView
		 */
		public function Mediator() {
			_notiys = new Vector.<Object>();
			
		}			
		override protected function onViewCompleteHandler(event:AssetsEvent):void {
			view.removeEventListener(AssetsEvent.COMPLETE_LOAD, onViewCompleteHandler);
			
			reSendNotify();
			isSkinLoad = true;
			viewDrawed(view);
			
			this.dispatchEvent(new AssetsEvent(AssetsEvent.COMPLETE_LOAD));
		}		
		protected function showDialog(dialogID:IDialogID):void{		
			
			var alertdialog:AlertDialog = new AlertDialog(this); 
			alertdialog.Builder=onCreateDialog(dialogID);			
			//var builder:AlertDialogBuilder = alertdialog.Builder;				
			alertdialog.show(dialogID);	
			
		}	
		/**
		 * 关闭窗口 
		 * @param dialogID
		 * 
		 */
		protected function dismiss(dialogID:IDialogID):void{
			var alertdialog:AlertDialog = AlertDialog.getAlertDialog(dialogID);
			if(alertdialog!=null){
				alertdialog.dismiss();				
			}else{
				Console.out(" 没有找到 dialogID:"+dialogID+"的弹出框！");
			}
		}
		/**
		 * 关闭所有的出现的窗口 
		 * 
		 */
		protected function dismissAll():void{
			AlertDialog.dismissAll();
		}
		protected function onCreateDialog(dialogID:IDialogID):AlertDialogBuilder{
			throw new OperateError("请重写 onCreateDialog 方法，因为 showDialog 方法。",this);
			return null;
		}
		
		/**
		 * 终极释放，什么都没有了。 
		 * 
		 */
		override public function dispose():void
		{			
			super.dispose();
			//dialog.dispose();
			
		}		
		
		/**
		 * 信息列队,用于在资源没有加载完成时，存储消息，该列对消息，会在资源加载完成后，被执行。
		 * @param notify
		 *
		 */
		public function push(name:String, notify:INotifyData):void {
			_notiys.push({"name": name, "notify": notify});
			
			if (isSkinLoad) {
				reSendNotify();
			}
		}
		
		private function reSendNotify():void {
			var currrentObj:Object;
			while (_notiys.length > 0) {
				currrentObj = _notiys.shift();
				//改成事件驱动
				//this.handerNotify(currrentObj.name,currrentObj.notify);
				FW::disHanderNotify(currrentObj.name, currrentObj.notify);
			}
		}
		
		
	}
}