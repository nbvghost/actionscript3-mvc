package com.game.framework.view
{
	import com.game.framework.events.AssetsEvent;
	import com.game.framework.interfaces.ICreateView;
	import com.game.framework.interfaces.INotifyData;
	import com.game.framework.model.NotifyData;
	
	
	
	/**
	 * MediaAssetItem.intiView() 被执行将发送 （Mediator.DEFAULT_TYPE，DEFAULT_NOTIFY）消息。
	 * MVC 的 父级 ，要重写  viewDrawed 方法和 name 方法
	 * @see com.game.framework.net.MediaAssetItem#initView()
	 *@author sixf
	 */
	public class Mediator extends BaseMediator 
	{
		private var _notiys:Vector.<Object>;
		private var isSkinLoad:Boolean=false;
		
		/**
		 * 默认 Mediator 又被初始化的消息类型
		 */
		public static const RE_INIT_TYPE:String="mediator_re_init_type";
		/**
		 * 默认 Mediator 又被初始化的消息 
		 */
		public static const RE_INIT_NOTIFY:NotifyData=new NotifyData(RE_INIT_TYPE,"Mediator 又被 initView ！");
		
		/**
		 * 默认 Mediator 又被初始化的消息类型
		 */
		public static const INIT_TYPE:String="mediator_init_type";
		/**
		 * 默认 Mediator 又被初始化的消息 
		 */
		public static const INIT_NOTIFY:NotifyData=new NotifyData(INIT_TYPE,"Mediator 被 initView ！");
		/**
		 *  实例化时，传入 ICreateView 视图对象
		 * @param view
		 * @see com.game.framework.interfaces.ICreateView
		 */
		public function Mediator(view:ICreateView)
		{
			super(view);			
			
			if(view.hasLoad){
				if(view!=null){
					view.addEventListener(AssetsEvent.COMPLETE_LOAD,onCompleteLoadHandler);
				}
			}else{
				isSkinLoad =true;
			}
			_notiys = new Vector.<Object>();
			
		}	
		/**
		 * 信息列队,用于在资源没有加载完成时，存储消息，该列对消息，会在资源加载完成后，被执行。
		 * @param notify
		 * 
		 */
		public function push(name:String,notify:INotifyData):void
		{
			_notiys.push({"name":name,"notify":notify});
			
			if(isSkinLoad){
				reSendNotify();		
			}			
		}
		private function reSendNotify():void{
			var currrentObj:Object;
			while(_notiys.length>0){
				currrentObj = _notiys.shift();
				this.handerNotify(currrentObj.name,currrentObj.notify);
			}
		}
		/**
		 * 当前视觉组件，实现的是  ICreateView 接口
		 * @see com.game.framework.interfaces.ICreateView
		 * @return 
		 * 
		 */
		override public function get view():ICreateView
		{
			// TODO Auto Generated method stub
			return super.view;
		}
		
		/**
		 *  
		 * @param value
		 * 
		 */
		override public function set view(value:ICreateView):void
		{
			// TODO Auto Generated method stub
			super.view = value;
		}		
		
		private function onCompleteLoadHandler(event:AssetsEvent):void
		{
			view.removeEventListener(AssetsEvent.COMPLETE_LOAD,onCompleteLoadHandler);
			reSendNotify();
			isSkinLoad = true;			
			viewDrawed(event);
		}
		
		/**
		 * 皮肤资源加载完成，并已经初始化完成 
		 * @param event com.game.framework.events.AssetsEvent
		 * @see com.game.framework.events.AssetsEvent
		 */
		protected function viewDrawed(event:AssetsEvent):void
		{
			//throw new Error("请重写 viewDrawed ! 目标："+this);	
		}
	}
}