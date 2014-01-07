package com.game.framework.views {
	import com.asvital.dev.Log;
	import com.game.framework.FW;
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.error.OperateError;
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.events.DissolveEvent;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.ITargetID;
	import com.game.framework.models.NotifyData;
	
	/**
	 * 
	 * Mediiator 被执行消失了。
	 * 
	 */
	[Event(name="dissolve", type="com.game.framework.events.DissolveEvent")]
	
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
		 * 为空
		 */
		public static const NONE:String="none";
		
		/**
		 * 默认 Mediator 又被初始化的消息类型,主要用于模块的初始化
		 */
		public static const RE_INIT_TYPE:String = "mediator_re_init_type";
		/**
		 * 暂时离开了。 
		 */
		public static const OUT_TYPE:String="out_type";
		/**
		 *  
		 */
		public static const IN_TYPE:String="in_type";
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
		
		
			
		FW var isdissolve:Boolean = false;
		
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
			
			viewOver();
		}
		protected function viewOver():void{
			reSendNotify();
			isSkinLoad = true;
			viewDrawed(view);			
			this.dispatchEvent(new AssetsEvent(AssetsEvent.COMPLETE_LOAD));
		}
		
		/**
		 * 消失</br>
		 * 模块消失，但并不释放内存，释放内存还是会根据，Mediator 周期来的。要释放内存很使用，dispose 方法 </br>
		 * 
		 * 
		 */
		protected function dissolve():void{
			if(FW::isdissolve==false){
				if(this.uimanager && this.view){				
					uimanager.removeEnterFrame(view);
					uimanager.removeReSize(view);
					uimanager.removeTimerRun(view);
				}
				FW::isdissolve=true;
				this.dispatchEvent(new DissolveEvent(DissolveEvent.DISSOLVE));
			}		
			
			
		}	
		
		/**
		 * 弹出一个窗口， 
		 * @param dialogID 指定窗口的ID，
		 * @param isNewCreate 是否新创建实例，还是用旧的、。
		 * 
		 */
		protected function showDialog(dialogID:ITargetID):void{		
			var alertdialog:AlertDialog;			
			alertdialog = AlertDialog.getAlertDialog(dialogID);
			if(alertdialog==null){
				alertdialog = new AlertDialog(this); 
				
			}							
			alertdialog.Builder=onCreateDialog(dialogID);
			alertdialog.show(dialogID);	
			
		}	
		/**
		 * 关闭窗口 
		 * @param dialogID
		 * 
		 */
		protected function dismiss(dialogID:ITargetID):void{
			var alertdialog:AlertDialog = AlertDialog.getAlertDialog(dialogID);
			if(alertdialog!=null){
				alertdialog.dismiss();				
			}else{
				Log.out(" 没有找到 dialogID:"+dialogID+"的弹出框！");
			}
		}
		/**
		 * 关闭所有的出现的窗口 
		 * 
		 */
		protected function dismissAll():void{
			AlertDialog.dismissAll();
		}
		protected function onCreateDialog(dialogID:ITargetID):AlertDialogBuilder{
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