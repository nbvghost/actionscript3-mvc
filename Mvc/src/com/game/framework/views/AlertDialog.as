package com.game.framework.views
{
	import com.asvital.dev.Log;
	import com.game.framework.data.AlertDialogBuilder;
	import com.game.framework.data.ConfigData;
	import com.game.framework.display.Layer;
	import com.game.framework.enum.MaskBackGroundType;
	import com.game.framework.events.DialogEvent;
	import com.game.framework.ifaces.ITargetID;
	import com.game.framework.ifaces.IURL;
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
		
		private var _targetURL:IURL;
		
		public static var DialogPool:Array=[];
		
		private var _visible:Boolean = true;
		private var dialogOver:Boolean =true;	
		private var _isDismiss:Boolean = false;
		public function AlertDialog(mediator:Mediator)
		{	
			
			
			callerBuilder = new AlertDialogBuilder();
			
			this.mediator = mediator;
			
			_targetURL = callerBuilder.view;
			
		}
		
		public function get visible():Boolean
		{
			return _visible;
		}
		public function get targetURL():IURL
		{
			return _targetURL;
		}
		
		public static function dismissAll(gc:Boolean = true):void{
			
			for (var i:int = 0; i < DialogPool.length; i++) 
			{
				var alertdialog:AlertDialog = DialogPool[i];
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
		public static function getAlertDialog(targetURL:IURL):AlertDialog{
			for (var i:int = 0; i < DialogPool.length; i++) 
			{
				var alertdialog:AlertDialog = DialogPool[i];
				if(alertdialog.targetURL.url==targetURL.url){
					return alertdialog;
				}	
			}	
			return null;
		}
		public static function getAlertDialogByID(targetURL:IURL,targetID:ITargetID):AlertDialog{
			for (var i:int = 0; i < DialogPool.length; i++) 
			{
				var alertdialog:AlertDialog = DialogPool[i];
				if(alertdialog.targetURL.url==targetURL.url && alertdialog.Builder.targetID.id==targetID.id){
					return alertdialog;
				}	
			}	
			return null;
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
			
			_targetURL =callerBuilder.view;
		}
		public function show(_ID:ITargetID=null):AlertDialog{		
			
			if(ConfigData.getInvalidDialogAlert()){
				return this;
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
			}
			
			dialogAssetItem.callerBuilder = callerBuilder;
			midLayer.addChild(dialogAssetItem);
			
			changeMaskLayer();
			
			
			dialogAssetItem.initView();
			_visible =true;
			
			if(DialogPool.indexOf(this)==-1){
				DialogPool.push(this);
			}
			
			this.dispatchEvent(new DialogEvent(DialogEvent.SHOW,callerBuilder));
			
			return this;
		}	
		
		public function changeMaskLayer():void{
			var midLayer:Layer=mediator.uimanager.uiLayer.secondFrontLayerContainer.midLayer;
			
			if(callerBuilder.modal){
				this.mediator.uimanager.uiLayer.setMaskAfter(midLayer.container,dialogAssetItem);
			}else{				
				this.mediator.uimanager.uiLayer.setMaskAfter(midLayer.container,dialogAssetItem,MaskBackGroundType.NONE);				
			}
		}
		
		/**
		 * 窗口关闭。 
		 * @param gc
		 */		
		public function dismiss(gc:Boolean=true):void{
			this.dispatchEvent(new DialogEvent(DialogEvent.DISMISSING,callerBuilder));
			
			var midLayer:Layer=mediator.uimanager.uiLayer.secondFrontLayerContainer.midLayer;
			
			if(dialogAssetItem){			
				this.mediator.uimanager.uiLayer.setMaskAfter(midLayer.container,dialogAssetItem,MaskBackGroundType.NONE);
			}
			
			
			if(gc){
				if(dialogAssetItem){
					dialogAssetItem.dispose();		
					
					var index:int = DialogPool.indexOf(this);
					if(index!=-1){
						DialogPool.splice(index,1);
					}
					
					//delete DialogPool[_targetID.id];
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
			_visible = false;
			
			this.dispatchEvent(new DialogEvent(DialogEvent.DISMISS,callerBuilder));
			//var midLayer:Layer=mediator.uimanager.uiLayer.secondFrontLayerContainer.midLayer;
			
			
			/*if(maskLayer){
			if(maskLayer.parent){
			maskLayer.parent.removeChild(maskLayer);
			}
			}*/
			
			
			for (var i:int = DialogPool.length-1; i >=0; i--) 
			{
				var alertDialog:AlertDialog = DialogPool[i];
				if(alertDialog.visible){
					alertDialog.changeMaskLayer();
					
					break;
				}
			}
			
			
		}
	}
}
