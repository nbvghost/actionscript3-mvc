package com.game.framework.geom
{
	import com.game.framework.error.OperateError;
	import com.game.framework.interfaces.IAssetItem;
	import com.game.framework.interfaces.IUIManager;
	import com.game.framework.logic.AssetsData;
	import com.game.framework.net.MediaAssetItem;
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	/**
	 * 与显示，动画，显示对象操作有关的静态类
	 *@author sixf
	 */
	public class ShowBox
	{
		/**
		 * 本类不须实例化，请使用静态方法！
		 * 
		 */
		public function ShowBox()
		{
			throw new OperateError("本类不须实例化，请使用静态方法！");
		}
		/**
		 * 中心居中 
		 * @param target
		 * 
		 */
		public static function center(target:DisplayObject,uimanager:IUIManager):void{
						
			target.x=(uimanager.getLayerRect().width-target.width)/2;
			target.y=(uimanager.getLayerRect().height-target.height)/2;
			
			
		}
		/**
		 *左右平移动画 ,left to right 
		 * @param at 代理对象
		 * @param duration 持续时间(秒)
		 * @param onComplete 动画完成后，回调
		 * @example dfds
		 * ShowBox.translationLRAnimation(animationTarget,0.2,function ():void{
				isTween = false;
			});
		 */
		public static function translationLRAnimation(at:AnimationTarget,duration:Number,onComplete:Function):void{			
			var ad:AssetsData = new AssetsData();			
			//TweenLite.to(mc, 0.5, {x:255, y:308, motionBlur:true, ease:Cubic.easeInOut});
			ad.asssetCompleteFunc = function (data:IAssetItem):void{
				TweenLite.to(at.intoMedia,duration,{x:0,onComplete:function():void{
					//at.outMedia.dispose();		
					//at.outMedia =null;			
					at.outMedia = at.intoMedia;	
					onComplete();
				}});
				TweenLite.to(at.outMedia,duration,{x:-at.outMedia.width,onComplete:function():void{
					//out.dispose();
					//out = into;
					
				}});
				
			}
			at.intoMedia.setDatainterface=ad;
			at.intoMedia.initView();
			at.intoMedia.x =at.outMedia.width;
		}
		/**
		 * 左右平移动画 ,right to left
		 * @param at
		 * @param duration
		 * @param onComplete
		 * 
		 */
		public static function translationRLAnimation(at:AnimationTarget,duration:Number,onComplete:Function):void{			
			var ad:AssetsData = new AssetsData();			
			ad.asssetCompleteFunc = function (data:IAssetItem):void{
				TweenLite.to(at.intoMedia,duration,{x:0,onComplete:function():void{
					//at.outMedia.dispose();					
					//at.outMedia =null;					
					at.outMedia = at.intoMedia;	
					onComplete();
				}});
				TweenLite.to(at.outMedia,duration,{x:at.outMedia.width,onComplete:function():void{
					//out.dispose();
					//out = into;
					
				}});
				
			}
			at.intoMedia.setDatainterface=ad;
			at.intoMedia.initView();
			at.intoMedia.x =-at.outMedia.width;			
		}
		/**
		 * 缩放显示对象 
		 * @param target 目标
		 * @param outBroder 目标的显示对象是否超出 Rect 的区域。
		 * @param rect 要显示的区域
		 * 
		 */
		public static function scale(target:DisplayObject,outBroder:Boolean,rect:Rect):void{
			var p:Number = rect.width/target.width;
			var tp:Number = rect.height/target.height;
			
			if(outBroder){
				if(p>tp){
					target.width=rect.width;			
					target.height =target.height*p;
				}else{
					target.height=rect.height;
					target.width =target.width*tp;
				}	
			}else{
				if(p>tp){					
					target.height=rect.height;
					target.width =target.width*tp;
				}else{
					target.width=rect.width;			
					target.height =target.height*p;
				}
			}		
			
			target.x = (rect.width-target.width)/2;
			target.y = (rect.height-target.height)/2;
			
		}
	}
}