package com.lassie.shepherd.services.loader
{
	import com.lassie.shepherd.services.ServiceWindow;
	import com.lassie.shepherd.events.ServiceEvent;
	import com.lassie.shepherd.core.ILibraryManager;
	import com.lassie.player.events.LibraryEvent;
	import flash.display.MovieClip;
	
	public final class LoaderWindow extends ServiceWindow
	{
		public var progressBar:MovieClip;
		
		private var _library:ILibraryManager;
		
	// --------------------------------------------------
	//  Constructor
	// --------------------------------------------------
		
		public function LoaderWindow():void
		{
			super();
			progressBar.stop();
		}
		
		override protected function init():void
		{
			setToMinSize(progressBar.width + (progressBar.x * 2), progressBar.y + progressBar.height + 10);
		}
		
	// --------------------------------------------------
	//  Public methods
	// --------------------------------------------------
		
		public function load(lib:ILibraryManager, csv:String, purge:Boolean=false):void
		{
			_library = lib;
			var id:String = _library.getUniqueLoaderName();
			_library.addLoadListener(id, LibraryEvent.PROGRESS, this._onLibLoadProgress);
			_library.addLoadListener(id, LibraryEvent.COMPLETE, this._onLibLoadComplete);
				
			if (purge)
			{
				_library.purgeAndLoad(id, csv);
			}
			else
			{
				_library.load(id, csv);
			}
		}
		
		public function showProgress(perc:Number):void
		{
			progressBar.gotoAndStop(Math.floor(perc * 100));
		}
		
		private function _complete():void
		{
			dispatchEvent(new ServiceEvent(ServiceEvent.LIBRARY_LOAD_COMPLETE, true));
			dispatchEvent(new ServiceEvent(ServiceEvent.CLOSE_SERVICE, true));
		}
		
	// --------------------------------------------------
	//  Event handlers
	// --------------------------------------------------
	
		private function _onLibLoadProgress(evt:LibraryEvent):void
		{
			progressBar.gotoAndStop(Math.floor(evt.percentLoaded * 100));
		}
		
		private function _onLibLoadComplete(evt:LibraryEvent):void
		{
			_library.removeLoadListener(evt.loaderName, LibraryEvent.PROGRESS, this._onLibLoadProgress);
			_library.removeLoadListener(evt.loaderName, LibraryEvent.COMPLETE, this._onLibLoadComplete);
			_library = null;
			_complete();
		}
	}
}