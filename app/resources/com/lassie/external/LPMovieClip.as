﻿/*** Lassie Engine* @author Greg MacWilliam.*/package com.lassie.external{	import flash.display.MovieClip;	import flash.display.DisplayObjectContainer;	import flash.events.Event;		/**	* Lassie Player MovieClip.	* This display class 	*/	public class LPMovieClip extends MovieClip implements ILPDisplaySocket	{		/**		* Specifies if the clip should automatically unload upon being removed from the stage.		* This value is true by default, becasue most Lassie media will be single use.		* Only disable this setting if a piece of media will be added and removed from stage multiple times.		*/		public var autoUnload:Boolean = true;				private var _lassiePlayer:ILassiePlayer;		private var _onActivate:Function;		private var _onDeactivate:Function;		private var __init__:Boolean = false;				public function LPMovieClip():void {			super();			addEventListener(Event.ADDED_TO_STAGE, this._onAddedToStage, false, 0, true);			addEventListener(Event.REMOVED_FROM_STAGE, this._onRemovedFromStage, false, 0, true);		}				/**		* Unloads the MovieClip to optimize for garbage collection.		* Activation events will no longer occur once the media has been unloaded.		*/		public function unload():void {			removeEventListener(Event.ADDED_TO_STAGE, this._onAddedToStage);			removeEventListener(Event.REMOVED_FROM_STAGE, this._onRemovedFromStage);			_onActivate = null;			_onDeactivate = null;			_lassiePlayer = null;		}				/**		* Initialize: called upon the first time adding the clip to stage.		*/		protected function _finit():void {			// override in subclass.		}				/**		* Initialize: called upon adding the clip to stage.		*/		protected function _init():void {			// override in subclass.		}				/**		* Uninitialize: called upon removing the clip from stage.		*/		protected function _uninit():void {			// override in subclass.		}				/**		* Removes all children from the display list.		*/		protected function _clearChildren():void {			while (numChildren > 0) removeChildAt(0);		}				/**		* Specifies a method to be called each time the clip is added to display.		* This method calls immediately upon being set if the clip is already present within the display.		*/		final public function get onActivate():Function {			return _onActivate;		}		final public function set onActivate($method:Function):void {			_onActivate = $method;			if (!!stage) _onActivate();		}				/**		* Specifies a method to be called each time the clip is removed from the display.		*/		final public function get onDeactivate():Function {			return _onDeactivate;		}		final public function set onDeactivate($method:Function):void {			_onDeactivate = $method;		}				/**		* Provides a reference to the Lassie Player interface.		*/		final public function get lassiePlayer():ILassiePlayer {			return _lassiePlayer;		}				/** @private called each time the clip is added to the display. */		private function _onAddedToStage($event:Event):void		{			var $parent:DisplayObjectContainer = parent;						// transverse up the display tree until a Lassie Player socket is found, or until the tree terminates.			while (_lassiePlayer == null && !!$parent) {				if ($parent is ILPDisplaySocket) _lassiePlayer = ILPDisplaySocket($parent).lassiePlayer;				$parent = $parent.parent;			}						// call first initialization.			if (!__init__) {				__init__ = true;				_finit();			}						// Call class-based init.			_init();						// Call reference-based activate method.			if (onActivate is Function) onActivate();		}				/** @private called each time the clip is removed from the display. */		private function _onRemovedFromStage($event:Event):void		{			// Call class-based uninit.			_uninit();						// Call reference-based deactivate method.			if (onDeactivate is Function) onDeactivate();						// Run automatic unload, if enabled.			if (autoUnload) unload();		}	}}