﻿package com.lassie.menu.ui{	final public class ListItem extends Object	{		public var label:String = "";		public var value:* = "";		public var key:String = "";				public function ListItem($label:String="", $value:*="", $key:String=""):void {			super();			label = $label;			value = $value;			key = $key;		}	}}