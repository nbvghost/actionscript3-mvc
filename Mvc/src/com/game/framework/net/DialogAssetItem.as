package com.game.framework.net
{
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.error.OperateError;
	import com.game.framework.ifaces.IAssetItem;
	import com.game.framework.ifaces.IDialog;
	import com.game.framework.ifaces.IDialogData;
	import com.game.framework.ifaces.INotifyData;
	import com.game.framework.ifaces.IURL;
	import com.game.framework.logic.AssetsData;
	import com.game.framework.views.AlertDialog;
	import com.game.framework.views.CreateView;
	import com.game.framework.views.Mediator;
	
	
	/**
	 *
	 *@author sixf
	 */
	public class DialogAssetItem extends MediaAssetItem
	{
		private var callBack:AssetsData = new AssetsData();
		
		private var _dialogContent:DialogAssetItem;
		private var _view:IURL;
		
		private var _notify:INotifyData;
		private var _alertDialogBuilder:AlertDialogBuilder;
		private var alertDialog:AlertDialog;
		public function DialogAssetItem(url:IURL,alert:AlertDialog,currentDomain:Boolean=true)
		{
			super(url, currentDomain);			
			callBack.asssetAllCompleteFunc = dialogLogComple;
			setDatainterface = callBack;
			this.alertDialog =alert;
		}
		
		public function get dialogContent():DialogAssetItem
		{
			return _dialogContent;
		}

		public function set dialogContent(value:DialogAssetItem):void
		{
			_dialogContent = value;
		}

		public function get alertDialogBuilder():AlertDialogBuilder
		{
			return _alertDialogBuilder;
		}

		public function set alertDialogBuilder(value:AlertDialogBuilder):void
		{
			_alertDialogBuilder = value;
		}
		
		public function getCreateView():CreateView{
			return this.createView;	
		}
		public function getMediator():Mediator{
			return this.mediator;
		}
		//dialog 窗口加载完后，加载 dialog 里的内容。
		private function dialogLogComple(data:IAssetItem):void{		
			if(_alertDialogBuilder==null){
				return;				
			}
			dialogContent = new DialogAssetItem(_alertDialogBuilder.view,alertDialog);
			var dialog:IDialog = mediator as IDialog;
			if(dialog==null){
				throw new OperateError("Dialog Content not IDialog,Please implement IDialog!",this);
			}
			dialog.setDislogContent(dialogContent,alertDialog);
			//this.addChild(dialogContent);
			
			if(dialogContent.parent==null){
				throw new OperateError("override setDislogContent(),and ");
			}
			callBack.asssetAllCompleteFunc = dialogContentComplete;
			dialogContent.setDatainterface = callBack;
			dialogContent.initView(_alertDialogBuilder.notify);
			//dialogContent=
		}
		
		override public function dispose():void
		{
			if(dialogContent!=null){
				dialogContent.dispose();
				//dialogContent.setDatainterface = null;
				dialogContent=null;
			}
			super.dispose();
		}
		
		private function dialogContentComplete(data:DialogAssetItem):void{
			
			var adbuil:IDialogData = data.getMediator() as IDialogData;
			if(adbuil==null){
				throw new OperateError("var adbuil:IDialogData = data.getMediator() as IDialogData; 转换出错。",this);
				return;
			}
			var view:CreateView = data.getCreateView();
			
			var alertdialogBuilder:AlertDialogBuilder = adbuil.getDialogBuilder();
			
			if(alertdialogBuilder==null){
				alertdialogBuilder = new AlertDialogBuilder;
				alertdialogBuilder.titleData = _alertDialogBuilder.titleData;
			}
			
			
			
			alertdialogBuilder.setDiaLogButtons(_alertDialogBuilder.getDiaLogButtons());			
		
			
			alertdialogBuilder.width = view.contentContainer.width
			alertdialogBuilder.height = view.contentContainer.height;		
					
			
			var dialog:IDialog = mediator as IDialog;
			
			dialog.setAlertDialogBuilder(alertdialogBuilder);
			adbuil.setAlertDialog(alertDialog);	
		}		
		
	}
}