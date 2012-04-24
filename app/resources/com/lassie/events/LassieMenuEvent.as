﻿/*** Lassie Engine* @author Greg MacWilliam.*/package com.lassie.events{	import flash.events.Event;	/**	* Event object used to send messages from the Lassie Player to the menu application.	*/	final public class LassieMenuEvent extends Event	{		/**		* Event type called upon loading a new game.		*/		static public const LOAD_COMPLETE:String = "lassieLoadComplete";				/**		* Event type called upon saving a game.		*/		static public const SAVE_COMPLETE:String = "lassieSaveComplete";				/**		* Event type called upon deleting a game.		*/		static public const CLEAR_COMPLETE:String = "lassieClearComplete";				/**		* Event type called upon rolling over an interactive object.		*/		static public const MOUSE_OVER:String = "lassieMenuOver";				/**		* Event type called upon rolling out from an interactive object.		*/		static public const MOUSE_OUT:String = "lassieMenuOut";				/**		* Creates a new LassieMenuEvent		* @param type The type of event. The type should use one of the LassieMenuEvent constant types.		*/		public function LassieMenuEvent($type:String, $bubbles:Boolean=false):void		{			super($type, $bubbles, false);		}	}}