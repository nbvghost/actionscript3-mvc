package com.game.framework.views
{
	import com.asvital.dev.Log;
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.data.ConfigData;
	import com.game.framework.display.Layer;
	import com.game.framework.events.DialogEvent;
	import com.game.framework.ifaces.ITargetID;
	import com.game.framework.logic.TargetID;
	import com.game.framework.net.DialogAssetItem;
	
	import flash.events.EventDispatcher;
	
	/**
	 * 
	 * 已经关闭
	 * 
	 */
	[Event(name="dismiss",type="com.game.framework.events.DialogEvent")]
	/**
	 * 窗口被打开
	 */
	[Event(name="show",type="com.game.framework.events.DialogEvent")]
	/**
	 * 正在关闭
	 */
	[Event(name="dismissing",type="com.game.framework.events.DialogEvent")]
	/**
	 * 点了关闭窗口按钮 
	 */	
	[Event(name="close_dialog",type="com.game.framework.events.DialogEvent")]
	/**
	 * 窗口实例 
	 *@author sixf
	 */
	public class AlertDialog extends EventDispatcher
	{
		private var callerBuilder:AlertDialogBuilder;
		private var dialogAssetItem:DialogAssetItem;
		private var mediator:Mediator;
		
		private var _targetID:ITargetID;
		
		public static var DialogPool:Object=new Object;
		
		
		private var dialogOver:Boolean =true;
		
		private var _isDismiss:Boolean = false;
		public function AlertDialog(mediator:Mediator)
		{	
			
			_targetID = AlertDialog.dialogID;
			callerBuilder = new AlertDialogBuilder();
			this.mediator = mediator;
			
		}
		
		public function get ID():ITargetID
		{
			return _targetID;
		}
		
		public static function dismissAll(gc:Boolean = true):void{
			for(var key:String in DialogPool){
				var alertdialog:AlertDialog = DialogPool[key];
				if(alertdialog!=null){
					alertdialog.dismiss(gc);
					//delete DialogPool[key];
				}				
			}			
		}
		/**
		 * 如有一个ID，就可以得到这个ID的窗口。全局的。 
		 * @param ID
		 * @return 
		 * 
		 */
		public static function getAlertDialog(ID:ITargetID):AlertDialog{
			return DialogPool[ID.id];
		}
		/**
		 * 生成一个ID，所有的窗口，使用这个方法 创建ID，被调用一个，会被加+1 
		 * @return 
		 * 
		 */
		public static function get dialogID():ITargetID{
			return TargetID.NewTargetID;
		}
		
		/**
		 * 这个窗口是否被关闭了。
		 * @return 
		 * 
		 */
		public function get isDismiss():Boolean
		{
			return _isDismiss;
		}
		
		public function set isDismiss(value:Boolean):void
		{
			_isDismiss = value;
		}
		
		/**
		 *  Builder 永远也不会为 null
		 * @return 
		 * 
		 */
		public function get Builder():AlertDialogBuilder{
			if(callerBuilder==null){
				callerBuilder = new AlertDialogBuilder();
			}			
			return callerBuilder;			
		}
		public function set Builder(value:AlertDialogBuilder):void{
			
			callerBuilder = value;
		}
		public function show(_ID:ITargetID=null):AlertDialog{		
			if(_ID!=null){
				_targetID = _ID;
			}else{
				_targetID = AlertDialog.dialogID;
			}
			if(callerBuilder==null){
				Log.out("AlertDialog.Builder 不能为空！ ");
				return this;
			}else{
				if(callerBuilder.view==null){
					Log.out("AlertDialog.view 不能为空！ ");
					return this;
				}
			}			
			
			var midLayer:Layer=mediator.uimanager.uiLayer.secondFrontLayerContainer.midLayer;
			
			if(dialogAssetItem==null){
				dialogAssetItem= new DialogAssetItem(ConfigData.getDialogView(),this);	
				midLayer.addChild(dialogAssetItem);
			}else{
				//  dialogAssetItem 这对象已经是 AlertDialog 本身的对象，不用再去列表去获取一次。
				//var childIndex:int=midLayer.getChildIndex(dialogAssetItem);
				//dialogAssetItem=midLayer.getChildAt(childIndex);
				//dialogAssetItem = midLayer.getChildByName(ConfigData.getDialogView().url) as DialogAssetItem;
				
				if(dialogAssetItem==null){
					dialogAssetItem= new DialogAssetItem(ConfigData.getDialogView(),this);	
					
				}else{
					if(dialogAssetItem.parent==null){
						midLayer.addChild(dialogAssetItem);
					}
				}
			}			
			dialogAssetItem.callerBuilder = callerBuilder;
			
			if(midLayer.numChildren!=0){
				midLayer.setChildIndex(dialogAssetItem,midLayer.numChildren-1);
			}
			
			dialogAssetItem.initView();			
			
			DialogPool[_targetID.id] =this;	
			this.dispatchEvent(new DialogEvent(DialogEvent.SHOW,callerBuilder));
			
			return this;
		}	
		/**
		 * 窗口关闭。 
		 * @param gc
		 */		
		public function dismiss(gc:Boolean=true):void{
			this.dispatchEvent(new DialogEvent(DialogEvent.DISMISSING,callerBuilder));
			
			if(gc){
				if(dialogAssetItem){
					dialogAssetItem.dispose();		
					delete DialogPool[_targetID.id];
				}		
				
				dialogAssetItem=null;
				mediator =null;
				_isDismiss =true;
			}else{
				if(dialogAssetItem){
					if(dialogAssetItem.parent){
						dialogAssetItem.parent.removeChild(dialogAssetItem);
					}
				}
			}
			
			
			this.dispatchEvent(new DialogEvent(DialogEvent.DISMISS,callerBuilder));
			
		}
	}
}
