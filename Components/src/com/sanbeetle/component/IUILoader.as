package com.sanbeetle.component
{
	import com.asvital.dev.Log;
	import com.sanbeetle.core.UIComponent;
	import com.sanbeetle.data.ScaleType;
	import com.sanbeetle.skin.IUILoaderSkin;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	

	/**
	 * 加载器，有缩放功能 
	 * @author Administrator
	 * 
	 */	
	public class IUILoader extends UIComponent
	{
		private var _loader:Loader;
		
		private var urlrequest:URLRequest;
		
		
		private var _smoothing:Boolean = false;
		private var _scaleType:String = ScaleType.NONE;
		
		private var _currentTarget:DisplayObject;
		
		private var maskmc:Shape = new Shape();
		
		private var loaderContext:LoaderContext;
		private var issetLoad:Boolean = false;
		
		private var _source:String="";
		
		private var loading:IUILoaderSkin;
		
		public function IUILoader()
		{
			super();
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			
			this.addChild(maskmc);
			
			loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			
			loading = new IUILoaderSkin();
			loading.p1.stop();
			loading.p2.stop();
			loading.p3.stop();			
		
		}
		/**
		 *  Loader.contentLoaderInfo 的引用
		 * @return 
		 * 
		 */
		public function get contentLoaderInfo():LoaderInfo
		{
			return _loader.contentLoaderInfo;
		}

		[Inspectable(defaultValue="")]
		public function get source():String
		{
			return _source;
		}
		/**
		 * 要加载的 显示资源的地址  同， load 方法 
		 * @param value
		 * @see #load()
		 */		
		public function set source(value:String):void
		{
			if(_source == value){
				return;
			}
			_source = value;
			if(_source != null && _source!=""){
				
				
				urlrequest = new URLRequest(_source);
				issetLoad = true;
				if(stage){
					pload();
				}
			}else{
				
				clean();
				this.updateUI();
				
				
				
			}
		}
		private function clean():void{
			try{
				
				_loader.close();
				_loader.unload();
				
			}catch(e:IOError){
				Log.error(e);	
			}
			
			if(_currentTarget){
				if(_currentTarget.parent){
					_currentTarget.parent.removeChild(_currentTarget);
				}
				if(_currentTarget is Bitmap){
					Bitmap(_currentTarget).bitmapData.dispose();
				}
			}
			
			if(loading.parent){
				loading.parent.removeChild(loading);
			}
			loading.p1.stop();
			loading.p2.stop();
			loading.p3.stop();
			
			_currentTarget= new Sprite();
			Sprite(_currentTarget).graphics.beginFill(0x000000,0.5);
			Sprite(_currentTarget).graphics.drawRect(0,0,this.trueWidth,this.trueHeight);
			Sprite(_currentTarget).graphics.endFill();
			this.addChild(_currentTarget);
		}
		/**
		 * 当前加载的显示对象 
		 * @return 
		 * 
		 */		
		public function get currentTarget():DisplayObject
		{
			return _currentTarget;
		}
		[Inspectable]
		/**
		 * 当是图片类型时，才有作用 ，对图片 进行平滑操作
		 * @return 
		 * @see flash.display.Bitmap#smoothing
		 */		
		public function get smoothing():Boolean
		{
			return _smoothing;
		}
		
		public function set smoothing(value:Boolean):void
		{
			_smoothing = value;
		}
		/**
		 * 
		 * 
		 * 对显示对象进行 大小 处理以及位置，参数为  ScaleType 静态属性
		 * @see com.sanbeetle.data.ScaleType#NONE
		 * @see com.sanbeetle.data.ScaleType#OUT_BORDER
		 * @see com.sanbeetle.data.ScaleType#IN_BORDER
		 * @see com.sanbeetle.data.ScaleType#CENTER_NOSCALE
		 * @return 
		 * 
		 */		
		[Inspectable(enumeration= "none,out_border,in_border,center_noscale",defaultValue = "none")]
		public function get scaleType():String
		{
			return _scaleType;
		}
		
		public function set scaleType(value:String):void
		{
			if(_scaleType != value){
				
				_scaleType = value;
				updateUI();
			}
		}
		/**
		 * 与 source 属性类似 ，不同的是，不在是一个单纯的 地址，可以给  URLRequest 对象传  data属性
		 * @param url =URLRequest.url
		 * @param urldata  =URLRequest.data
		 * @see flash.net.URLRequest
		 */		
		public function load(url:String,urldata:Object=null):void{
			_source= url;
			urlrequest = new URLRequest(url);
			urlrequest.data = urldata;
			issetLoad = true;
			if(stage){
				pload();
			}
			
		}
		
		override public function dispose():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onCompleteHandler);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			
			loading.removeEventListener(MouseEvent.CLICK,onreload);
			
			loading.p1.stop();
			loading.p2.stop();
			loading.p3.stop();
			
			super.dispose();
		}
		
		override protected function onAddStage():void
		{
			if(issetLoad){
				pload();
			}
		}
		
		private function pload():void{
			
			_loader.load(urlrequest,loaderContext);
			
		}
		private function onIOErrorHandler(event:IOErrorEvent):void
		{
			loading.buttonMode = true;
			loading.p1.gotoAndStop(11);
			loading.p2.gotoAndStop(21);
			loading.p3.gotoAndStop(1);
			loading.addEventListener(MouseEvent.CLICK,onreload);
		}
		
		private function onProgressHandler(event:ProgressEvent):void
		{
			if(loading.parent==null){
				this.addChild(loading);
				
				loading.p1.play();
				loading.p2.play();
				loading.p3.play();
				
				
			}			
			
			loading.x = Math.round((trueWidth-loading.width)/2);
			loading.y = Math.round((trueHeight-loading.height)/2);
			
			loading.bg.gotoAndStop(int((event.bytesLoaded/event.bytesTotal)*100));
			
		}
		
		private function onreload(event:MouseEvent):void
		{
			loading.buttonMode = false;
			loading.removeEventListener(MouseEvent.CLICK,onreload);
			if(loading.parent){
				loading.parent.removeChild(loading);	
			}
			pload();
		}
		
		override protected function updateUI():void
		{
			
			
			
			if(_currentTarget){
				var pih:Number = _currentTarget.height/trueHeight;
				var piw:Number = _currentTarget.width/trueWidth;
				
				var cupi:Number= _currentTarget.height/_currentTarget.width;
				
				switch(_scaleType){
					case ScaleType.CENTER_NOSCALE:
					case ScaleType.NONE:
						
						_currentTarget.scaleX = 1;
						_currentTarget.scaleY = 1;
						
						break;
					case ScaleType.IN_BORDER:
						if(pih>piw){
							_currentTarget.height =trueHeight;
							_currentTarget.width = _currentTarget.height/cupi;
						}else{
							_currentTarget.width = trueWidth;
							_currentTarget.height = _currentTarget.width*cupi;
							
						}
						break;
					case ScaleType.OUT_BORDER:
						if(pih>piw){
							_currentTarget.width = trueWidth;
							_currentTarget.height = _currentTarget.width*cupi;
							
						}else{
							
							_currentTarget.height =trueHeight;
							_currentTarget.width = _currentTarget.height/cupi;
							
						}
						break;
				}
				
				if(_scaleType!=ScaleType.NONE){
					_currentTarget.x = (trueWidth-_currentTarget.width)/2;
					_currentTarget.y = (trueHeight-_currentTarget.height)/2;
				}
				
			}
			
			maskmc.graphics.clear();
			maskmc.graphics.beginFill(0x00ff00,0);
			//maskmc.graphics.lineStyle(1);
			maskmc.graphics.drawRect(0,0,this.trueWidth,this.trueHeight);
			maskmc.graphics.endFill();
		}
		
		
		private function onCompleteHandler(event:Event):void
		{
			
			
			
			loading.p1.stop();
			loading.p2.stop();
			loading.p3.stop();
			
			if(loading.parent){
				loading.parent.removeChild(loading);	
			}
			
			if(_currentTarget){
				if(_currentTarget.parent){
					_currentTarget.parent.removeChild(_currentTarget);
				}
				if(_currentTarget is Bitmap){
					Bitmap(_currentTarget).bitmapData.dispose();
				}
			}
			issetLoad = false;
			
			_currentTarget = _loader.content;	
			
			
			
			if(_smoothing && _loader.contentLoaderInfo.contentType!="application/x-shockwave-flash"){			
				
				var bd:BitmapData = new BitmapData(_currentTarget.width,_currentTarget.height,true,0x000000);				
				bd.draw(_currentTarget,null,null,null,null,true);
				var bit:Bitmap = new Bitmap(bd,PixelSnapping.AUTO,true);
				_currentTarget = bit;
				this.addChild(_currentTarget);
			}else{
				
				this.addChild(_currentTarget);
			}
			
			_currentTarget.mask = maskmc;
			
			
			this.addChild(maskmc);
			
			if(_source==null || _source=="" || _source.length<8){
				clean();
			}
			
			updateUI();
			
			
			
			
		}
		
	}
}