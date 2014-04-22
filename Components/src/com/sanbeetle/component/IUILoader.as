package com.sanbeetle.component
{
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
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	

	
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

		public function get contentLoaderInfo():LoaderInfo
		{
			return _loader.contentLoaderInfo;
		}

		[Inspectable(defaultValue="")]
		public function get source():String
		{
			return _source;
		}
		
		public function set source(value:String):void
		{
			if(_source != value && value!=""){
				
				_source = value;
				urlrequest = new URLRequest(_source);
				issetLoad = true;
				if(stage){
					pload();
				}
			}
		}
		
		public function get currentTarget():DisplayObject
		{
			return _currentTarget;
		}
		[Inspectable]
		/**
		 * 当是图片类型时，才有作用 
		 * @return 
		 * 
		 */		
		public function get smoothing():Boolean
		{
			return _smoothing;
		}
		
		public function set smoothing(value:Boolean):void
		{
			_smoothing = value;
		}
		[Inspectable(enumeration= "none,out_border,in_border",defaultValue = "none")]
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
		
		public function load(url:String,urldata:Object=null):void{
			
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
		
		
		override public function onStageHandler(event:Event):void
		{
			if(issetLoad){
				pload();
			}
		}
		
		private function pload():void{
			
			_loader.load(urlrequest,loaderContext);
			
		}
		protected function onIOErrorHandler(event:IOErrorEvent):void
		{
			loading.buttonMode = true;
			loading.p1.gotoAndStop(11);
			loading.p2.gotoAndStop(21);
			loading.p3.gotoAndStop(1);
			loading.addEventListener(MouseEvent.CLICK,onreload);
		}
		
		protected function onProgressHandler(event:ProgressEvent):void
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
		
		protected function onreload(event:MouseEvent):void
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
					case ScaleType.NONE:
						
						
						
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
		
		
		protected function onCompleteHandler(event:Event):void
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
			
			
			updateUI();
			
		}
		
	}
}