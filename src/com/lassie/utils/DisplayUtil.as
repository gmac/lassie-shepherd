﻿package com.lassie.utils{	import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import flash.display.InteractiveObject;	import flash.display.MovieClip;		public final class DisplayUtil	{		/*		* Stops all MovieClip within a DOM branch.		* @param $display: the display object container to loop through.		*/		static public function stopAllClips($display:DisplayObjectContainer):void		{			// if object is a MovieClip, stop() it.			if ($display is MovieClip) MovieClip($display).stop();						// loop through object's children and recursively apply method to all DOCs.			for (var j:int = 0; j < $display.numChildren; j++)			{				var $child:DisplayObject = $display.getChildAt(j);				if ($child is DisplayObjectContainer) stopAllClips($child as DisplayObjectContainer);			}		}				/*		* Performs basic cleanup on a display object.		*/		static public function clearDisplayObject($target:DisplayObject):void		{			// if a valid reference was provided			if ($target != null)			{				// clear DisplayObject from any parent containers.				if ($target.parent != null) {					$target.parent.removeChild($target);				}								// stop all clips within a DisplayObjectContainer				if ($target is DisplayObjectContainer) {					DisplayUtil.stopAllClips($target as DisplayObjectContainer);				}			}		}				/*		* Seeks, removes, and returns a child object from a container.		* @param $scope: container to pull the child from.		* @param $childName: name of the child object o extract.		* @return DisplayObject: the child object, or null if not found.		*/		static public function extractChildByName($scope:DisplayObjectContainer, $childName:String):DisplayObject		{			return extractChild( $scope.getChildByName($childName) );		}				/*		* Seeks, removes, and returns a child object from a container.		* @param $scope: container to pull the child from.		* @param $childIndex: the index at which to extract a child.		* @return DisplayObject: the child object, or null if it did not exist.		*/		static public function extractChildAt($scope:DisplayObjectContainer, $childIndex:int):DisplayObject		{			if ($childIndex < $scope.numChildren)			{				return extractChild( $scope.getChildAt($childIndex) );			}			return null;		}				/*		* Removes an object from its parent and returns the detached child reference.		* @param $child: the child object to detach.		* @return DisplayObject: the detached child reference.		*/		static public function extractChild($child:DisplayObject):DisplayObject		{			if ($child != null)			{				if ($child.parent != null) return $child.parent.removeChild($child);				else return $child;			}			return null;		}				/*		* Configures mouse responsiveness of genaric display objects.		* @param $display: the display object to configure.		* @param $enable: enable/disable the display's mouse.		*/		static public function setMouseEnabled($display:DisplayObject, $enable:Boolean=false):void		{			if ($display is DisplayObjectContainer)			{				// completely disable containers				DisplayObjectContainer($display).mouseEnabled = $enable;				DisplayObjectContainer($display).mouseChildren = $enable;			}			else if ($display is InteractiveObject)			{				// completely disable interactive				InteractiveObject($display).mouseEnabled = $enable;			}		}				static public function getHexString(hex:Number):String		{			var r:Number = (hex >> 16);			var g:Number = (hex >> 8 ^ r << 8);			var b:Number = (hex ^ (r << 16 | g << 8));						var red:String   = r.toString(16);			var green:String = g.toString(16);			var blue:String  = b.toString(16);						red = (red.length < 2) ? '0' + red : red;			green = (green.length < 2) ? '0' + green : green;			blue = (blue.length < 2) ? '0' + blue : blue;						return "#"+(red + green + blue).toUpperCase();		}	}}