package com.game.framework.net
{
	import com.game.framework.FW;
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.data.ConfigData;
	import com.game.framework.data.DialogDataItem;
	import com.game.framework.error.ErrorType;
	import com.game.framework.error.OperateError;
	import com.game.framework.events.DissolveEvent;
	import com.game.framework.ifaces.IAssetItem;
	import com.game.framework.ifaces.IDialog;
	import com.game.framework.ifaces.IDialogData;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IURL;
	import com.game.framework.logic.AssetsData;
	import com.game.framework.views.AlertDialog;
	import com.game.framework.views.CreateView;
	import com.game.framework.views.Mediator;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class DialogAssetItem extends MediaAssetItem
	{
		
		
		/**
		 * 窗口内容
		 */
		private var _dialogContent:DialogContentAssetItem;
		private var _view:IURL;
		
		private var _notify:INotifyData;
		
		private var _callerBuilder:AlertDialogBuilder;
		private var alertDialog:AlertDialog;
		private var calleeBuilder:AlertDialogBuilder;
		
		public function DialogAssetItem(url:IURL,alert:AlertDialog,currentDomain:Boolean=true)
		{
			super(url, currentDomain);			
			var callBack:AssetsData = new AssetsData();
			callBack.asssetAllCompleteFunc = dialogLogComple;		
			
			
			callBack.asssetCompleteFunc = reinitComplete;
			setDatainterface = callBack;
			this.alertDialog =alert;
		}			
		
		private function reinitComplete(data:IAssetItem):void
		{
			if(_dialogContent!=null && _callerBuilder!=null){
				_dialogContent.initView(_callerBuilder.notify);				
			}
		}
		/**
		 * 窗口内容
		 * @return 
		 * 
		 */
		public function get dialogContent():DialogContentAssetItem
		{
			return _dialogContent;
		}
		
		public function get callerBuilder():AlertDialogBuilder
		{
			return _callerBuilder;
		}
		
		public function set callerBuilder(value:AlertDialogBuilder):void
		{
			if(_callerBuilder!=null){
				_callerBuilder.titleData.removeEventListener(DialogDataItem.labelChange,onChangeHandler);
				_callerBuilder.titleData.removeEventListener(DialogDataItem.viewChange,onChangeHandler);
				_callerBuilder.removeEventListener(AlertDialogBuilder.sideSelectIndexChange,onChangeHandler);
			}
			_callerBuilder = value;
		}
		
		/**
		 * 在 dialog 里， DissolveEvent。DISSOLVE 无效
		 * @param event
		 * 
		 */
		override protected function onDissolveHandler(event:DissolveEvent):void
		{
			
		}
		
		
		public function getCreateView():CreateView{
			return this.createView;	
		}
		public function getMediator():Mediator{
			return this.mediator;
		}		
		private var cacheDialogContent:Object = new Object();
		/**
		 * dialog 窗口加载完后，加载 dialog 里的内容。
		 * 窗口皮肤，那个外面的框框   
		 * @param data
		 * 
		 */		
		private function dialogLogComple(data:IAssetItem):void{	
			
			if(_callerBuilder==null){
				return;				
			}
			//如果不为空的话，说明已经被加载过了。将不会再加载，但会执行，reinitComplete
			if(_dialogContent!=null){
				return;
			}
			var callBack:AssetsData = new AssetsData();
			_dialogContent = new DialogContentAssetItem(_callerBuilder.view);
			var dialog:IDialog = mediator as IDialog;
			if(dialog==null){
				throw new OperateError("Dialog Content not IDialog,Please implement IDialog!",this);
			}
			dialog.setDislogContent(_dialogContent,alertDialog);			
			
			if(_dialogContent.parent==null){
				throw new OperateError("override setDislogContent(),and ");
			}
			//callBack.asssetAllCompleteFunc = dialogContentComplete;
			callBack.asssetAllCompleteFunc  =null;
			callBack.asssetCompleteFunc = dialogContentComplete;
			_dialogContent.setDatainterface = callBack;
			_dialogContent.initView(_callerBuilder.notify);			
		}
		
		override public function dispose():void
		{
			disposeAlertBuilder(alertDialog.Builder);
			disposeAlertBuilder(_callerBuilder);
			disposeAlertBuilder(calleeBuilder);
			
			if(_dialogContent!=null){
				_dialogContent.setDatainterface = null;
				_dialogContent.dispose();
				//dialogContent.setDatainterface = null;
				_dialogContent=null;
			}
			
			setDatainterface=null;
			super.dispose();
		}
		private function disposeAlertBuilder(_builder:AlertDialogBuilder):void{
			
			
				if(_builder){
					_builder.titleData.removeEventListener(DialogDataItem.labelChange,onChangeHandler);				
					_builder.titleData.removeEventListener(DialogDataItem.viewChange,onChangeHandler);
					_builder.removeEventListener(AlertDialogBuilder.sideSelectIndexChange,onChangeHandler);
					if(_builder.sideBtnData){
						for (var i:int = 0; i < _builder.sideBtnData.length; i++) 
						{
							_builder.sideBtnData[i].view = null;
						}
						
						
					}
					if(_builder.getDiaLogButtons()){
						for (var j:int = 0; j < _builder.getDiaLogButtons().length; j++) 
						{
							_builder.getDiaLogButtons()[i].clickHandler = null;
							
						}
						
					}				
				}
			
		}
		private function dialogContentComplete(data:DialogContentAssetItem):void{
			
			var dialogContentIF:IDialogData = data.getMediator() as IDialogData;
			if(dialogContentIF==null){
				throw new OperateError("var adbuil:IDialogData = data.getMediator() as IDialogData; 转换出错。",this);
				return;
			}
			var view:CreateView = data.getCreateView();
			
			calleeBuilder = dialogContentIF.getDialogBuilder();
			
			if(calleeBuilder==null){
				calleeBuilder = new AlertDialogBuilder;
				calleeBuilder.titleData = _callerBuilder.titleData;
				calleeBuilder.modal = _callerBuilder.modal;
				calleeBuilder.isShadow = _callerBuilder.isShadow;
				calleeBuilder.titleCenter = _callerBuilder.titleCenter;
				calleeBuilder.sideSelectIndex = _callerBuilder.sideSelectIndex;	
			}else{
				if(calleeBuilder.sideSelectIndex==-1){
					calleeBuilder.sideSelectIndex = _callerBuilder.sideSelectIndex;
				}
			}
			
			if(calleeBuilder.titleCenter==false || _callerBuilder.titleCenter==false){
				calleeBuilder.titleCenter = false;
			}		
			
			
			if(calleeBuilder.sideBtnData.length<=0){
				
				try{
					var content:MovieClip=MovieClip(view.FW::skinContainer.content);
					var dialogBound:MovieClip = content.getChildByName(ConfigData.getDialogContentBoundName()) as MovieClip;
					dialogBound.x = 0;
					dialogBound.y = 0;
					dialogBound.mouseChildren = false;
					dialogBound.mouseEnabled = false;
					dialogBound.stop();
					dialogBound.visible =false;
					if(dialogBound.parent){
						dialogBound.parent.setChildIndex(dialogBound,0);
					}
					calleeBuilder.width = dialogBound.width
					calleeBuilder.height = dialogBound.height;
				}catch(e:Error){
					throw new OperateError("没有找到名为"+ConfigData.getDialogContentBoundName()+"的影片剪辑。",this,ErrorType.not_dialog_content_bound_si_target);
				}
				
				//Log.out(MovieClip(view.FW::skinContainer.content),MovieClip(view.FW::skinContainer.content).getChildByName("dialogBound"));
			}
			
			calleeBuilder.setDiaLogButtons(_callerBuilder.getDiaLogButtons());			
			
			
			
			
			var dialog:IDialog = mediator as IDialog;
			
			dialog.setAlertDialogBuilder(calleeBuilder,dialogContentIF);
			dialogContentIF.setAlertDialog(alertDialog);	
			
			
			
			alertDialog.Builder.titleData.addEventListener(DialogDataItem.labelChange,onChangeHandler);
			alertDialog.Builder.titleData.addEventListener(DialogDataItem.viewChange,onChangeHandler);
			alertDialog.Builder.addEventListener(AlertDialogBuilder.sideSelectIndexChange,onChangeHandler);
			//alertdialogBuilder.titleData.addEventListener(DialogDataItem.labelChange,onChangeHandler);
			//alertdialogBuilder.titleData.addEventListener(DialogDataItem.viewChange,onChangeHandler);
		}		
		
		protected function onChangeHandler(event:Event):void
		{
			switch(event.type){
				case DialogDataItem.labelChange:
					calleeBuilder.titleData.label = alertDialog.Builder.titleData.label;
					break;
				case DialogDataItem.viewChange:
					calleeBuilder.titleData.view = alertDialog.Builder.titleData.view;
					break;
				case AlertDialogBuilder.sideSelectIndexChange:
					calleeBuilder.sideSelectIndex = alertDialog.Builder.sideSelectIndex;
					break;
			}
			
		}
		
	}
}