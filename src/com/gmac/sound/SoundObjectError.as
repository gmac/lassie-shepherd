﻿/*** SoundObject: sound control framework for ActionScript3.* @author Greg MacWilliam* @version 1.0*//*** Licensed under the MIT License* * Copyright (c) 2009 Greg MacWilliam* * Permission is hereby granted, free of charge, to any person obtaining a copy of* this software and associated documentation files (the "Software"), to deal in* the Software without restriction, including without limitation the rights to* use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of* the Software, and to permit persons to whom the Software is furnished to do so,* subject to the following conditions:* * The above copyright notice and this permission notice shall be included in all* copies or substantial portions of the Software.* * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS* FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER* IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.* * http://code.google.com/p/sound-skin/* http://www.opensource.org/licenses/mit-license.php */package com.gmac.sound{	import flash.events.Event;		/**	* SoundObjectError constructs error message thrown by the SoundObject framework.	*/	final public class SoundObjectError extends Error	{		/**		* Constructs a new SoundObjectError.		* @param message The error message.		*/		public function SoundObjectError($message:String):void		{			super("[SoundObject: "+ $message +"]");		}	}}