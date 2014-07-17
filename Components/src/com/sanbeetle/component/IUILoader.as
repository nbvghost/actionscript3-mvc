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
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	
	
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
		
		//private var _currentTarget:DisplayObject;
		
		private var maskmc:Shape = new Shape();
		private var defaultmc:Shape = new Shape();
		
		private var loaderContext:LoaderContext;
		private var issetLoad:Boolean = false;
		
		private var _source:String="";
		
		private var loading:IUILoaderSkin;
		
		private var urlStream:URLStream= new URLStream();
		
		private var _data:ByteArray = new ByteArray();
		
		
		
		public function IUILoader()
		{
			super();
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgressHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);	
			
			//this.mouseChildren = false;
			//this.mouseEnabled = false;
			//_loader.mouseEnabled = false;
			//_loader.mouseChildren = false;
			
			
			urlStream.addEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			urlStream.addEventListener(ProgressEvent.PROGRESS,onStreamProgressHandler);
			urlStream.addEventListener(Event.COMPLETE,onStreamCompleteHandler);
			
			
			
			loaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			
			loading = new IUILoaderSkin();
			loading.mouseChildren = false;
			loading.stop();
			
			
			
			
			this.addChild(defaultmc);
			this.addChild(_loader);			
			
			this.addChild(maskmc);
		}
		public function get pragressBar():IUILoaderSkin{
			return loading;
		}
		protected function onStreamCompleteHandler(event:Event):void
		{
			if(defaultmc.parent){
				defaultmc.parent.removeChild(defaultmc);
			}
			
			
			if(loading.parent){
				loading.parent.removeChild(loading);	
			}
			
			loading.stop();
			
			issetLoad = false;
		}
		
		override protected function createUI():void
		{
			loading.x = Math.round((trueWidth-loading.width)/2);
			loading.y = Math.round((trueHeight-loading.height)/2);
			
			this.addChild(loading);
		}
		
		
		protected function onStreamProgressHandler(event:ProgressEvent):void
		{
			
			
			
			urlStream.readBytes(_data,_data.length,urlStream.bytesAvailable);
			
			
			
			_loader.loadBytes(_data,loaderContext);		
			
			
			if(!loading.isPlaying){
				
				
				loading.play();				
			}	
			if(loading.parent==null){
				this.addChild(loading);
			}
			
			loading.x = Math.round((trueWidth-loading.width)/2);
			loading.y = Math.round((trueHeight-loading.height)/2);
			
			//loading.bg.gotoAndStop(int((event.bytesLoaded/event.bytesTotal)*100));
			
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
				_loader.unloadAndStop();
				
			}catch(e:IOError){
				Log.error(e);	
			}
			
			_data.clear();
			
			try{
				urlStream.close();
			}catch(e:IOError){
				trace(e);
			}
			/*if(_currentTarget){
			if(_currentTarget.parent){
			_currentTarget.parent.removeChild(_currentTarget);
			}
			if(_currentTarget is Bitmap){
			Bitmap(_currentTarget).bitmapData.dispose();
			}
			}*/
			
			
			if(loading.parent){
				loading.parent.removeChild(loading);
			}
			loading.stop();
			
			
			
			this.addChild(defaultmc);
		}
		/**
		 * 当前加载的显示对象 
		 * @return 
		 * 
		 */		
		public function get content():DisplayObject
		{
			return _loader.content
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
			
			loading.stop();
			
			urlStream.removeEventListener(IOErrorEvent.IO_ERROR,onIOErrorHandler);
			urlStream.removeEventListener(ProgressEvent.PROGRESS,onStreamProgressHandler);
			urlStream.removeEventListener(Event.COMPLETE,onStreamCompleteHandler);
			
			
			super.dispose();
		}
		
		override protected function onAddStage():void
		{
			if(issetLoad){
				pload();
			}
		}
		
		private function pload():void{
			_loader.unloadAndStop();
			_loader.unload();
			
			_data.clear();
			
			urlStream.load(urlrequest);
			
			//this.addChild(loading);	
			//_loader.load(urlrequest,loaderContext);
			
		}
		private function onIOErrorHandler(event:IOErrorEvent):void
		{
			
			loading.buttonMode = true;
			loading.stop();
			loading.addEventListener(MouseEvent.CLICK,onreload);
		}
		
		private function onProgressHandler(event:ProgressEvent):void
		{
			
			
			
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
		
		override public function upDisplayList():void
		{
			this.updateUI();
		}
		
		
		override protected function updateUI():void
		{
			
			
			if(_loader.content){
				var pih:Number = _loader.content.height/trueHeight;
				var piw:Number = _loader.content.width/trueWidth;
				
				var cupi:Number= _loader.content.height/_loader.content.width;
				
				switch(_scaleType){
					case ScaleType.CENTER_NOSCALE:
					case ScaleType.NONE:
						
						_loader.content.scaleX = 1;
						_loader.content.scaleY = 1;
						
						break;
					case ScaleType.IN_BORDER:
						if(pih>piw){
							_loader.content.height =trueHeight;
							_loader.content.width = _loader.content.height/cupi;
						}else{
							_loader.content.width = trueWidth;
							_loader.content.height = _loader.content.width*cupi;
							
						}
						break;
					case ScaleType.OUT_BORDER:
						if(pih>piw){
							_loader.content.width = trueWidth;
							_loader.content.height = _loader.content.width*cupi;
							
						}else{
							
							_loader.content.height =trueHeight;
							_loader.content.width = _loader.content.height/cupi;
							
						}
						break;
				}
				
				if(_scaleType!=ScaleType.NONE){
					_loader.x = (trueWidth-_loader.content.width)/2;
					_loader.y = (trueHeight-_loader.content.height)/2;
				}
				
			}
			defaultmc.graphics.clear();
			defaultmc.graphics.beginFill(0x000000,0.5);
			defaultmc.graphics.drawRect(0,0,this.trueWidth,this.trueHeight);
			defaultmc.graphics.endFill();
			
			
			maskmc.graphics.clear();
			maskmc.graphics.beginFill(0x00ff00,0);
			//maskmc.graphics.lineStyle(1);
			maskmc.graphics.drawRect(0,0,this.trueWidth,this.trueHeight);
			maskmc.graphics.endFill();
		}
		
		
		private function onCompleteHandler(event:Event):void
		{
			
			//trace(_loader.width,_loader.height,_loader.content.width,_loader.content.height);
			
			
			
			
			
			
			
			
			/*if(_currentTarget){				
			if(_currentTarget is Bitmap){
			if(_currentTarget.parent){
			_currentTarget.parent.removeChild(_currentTarget);
			}
			Bitmap(_currentTarget).bitmapData.dispose();
			}
			}*/
			
			
			
			//_currentTarget = _loader.content;	
			
			
			
			if(_smoothing && _loader.contentLoaderInfo.contentType!="application/x-shockwave-flash"){			
				
				//var bd:BitmapData = new BitmapData(_currentTarget.width,_currentTarget.height,true,0x000000);				
				//bd.draw(_currentTarget,null,null,null,null,true);
				////var bit:Bitmap = new Bitmap(bd,PixelSnapping.AUTO,true);
				var bit:Bitmap = _loader.content as Bitmap;
				if(bit && bit.bitmapData){	
					bit.smoothing = true;
					//trace("1");
					try{
						bit.bitmapData.draw(bit.bitmapData.clone(),null,null,null,null,true);
					}catch(e:ArgumentError){
						trace(e);
					}
				}
				//_currentTarget = bit;
				//this.addChild(_currentTarget);
			}else{
				
				//this.addChild(_currentTarget);
			}
			
			_loader.mask = maskmc;
			
			
			this.addChild(maskmc);
			
			if(_source==null || _source=="" || _source.length<8){
				clean();
			}
			
			updateUI();
			
			
			
			
		}
		
	}
}