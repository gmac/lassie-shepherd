﻿/*** Lassie Engine Game Player* @author Greg MacWilliam.*/package com.lassie.player.model{	import com.lassie.utils.XmlUtil;	final public class RoomLayerState extends DataModel	{		private var _index:int = -1;		private var _parentLayer:RoomLayer;		private var _data:RoomLayerStateData;		public function RoomLayerState($id:String, $parent:RoomLayer):void		{			super($id);			_data = new RoomLayerStateData();			_parentLayer = $parent;			refresh();		}	//-------------------------------------------------	// Overrides	//-------------------------------------------------		override internal function parse($xml:XML):void		{			XmlUtil.parseAttributes(_data, $xml.@*);			XmlUtil.parseAttributes(_data, $xml.param.@*);			_data.title = XML($xml.title);			_data.actions.parse(XML($xml.actions));			_data.itemActions.parse(XML($xml.items));			_data.actionProps = XML($xml.vars);			_loaded = true;		}		override public function destroy():void {			_parentLayer = null;			_data = null;			_cache = null;		}		override public function refresh():void {			// a state cache is refreshed initially, and then each time it is pulled from its layer.			// states DO NOT subscribe directly to the game cache to recieve updates.			_cache = parent.cache.getNamespace(id);		}	//-------------------------------------------------	// State property fields	//-------------------------------------------------		/**		* Gets a reference to the state's parent room layer.		*/		public function get parent():RoomLayer {			return _parentLayer;		}		/**		* Specifies the index of the state within the parent layer's state list.		*/		public function get index():int {			return _index;		}		/**		* Sets the state's index within the parent layer's state list.		* This action is performed by the parent layer while parsing loaded data; AFTER all states are known.		*/		internal function setIndex($index:int):void {			_index = $index;		}	//-------------------------------------------------	// State read-only	//-------------------------------------------------		/**		* Title captions for the state.		*/		public function get title():String {			if (_cache.hasValue(RoomLayerStateData.TITLE)) {				var $str:String = _cache.pull( RoomLayerStateData.TITLE, _data.title.toXMLString() ) as String;				return _selectLanguage( new XML($str) );			}			return _selectLanguage(_data.title);		}		public function set title($val:String):void {			_cache.push( RoomLayerStateData.TITLE, $val, _data.title.toXMLString(), !_loaded );			update();		}		/**		* State interactions list.		*/		public function get actions():ActionList {			return _data.actions;		}		/**		* State item actions list.		*/		public function get itemActions():ActionList {			return _data.itemActions;		}		/**		* Custom properties list provided to the interaction API.		*/		public function get actionProps():XML {			return _data.actionProps.copy();		}	//-------------------------------------------------	// State properties	//-------------------------------------------------		/**		* X-position.		*/		public function get x():int {			return _cache.pull( RoomLayerStateData.X, _data.x ) as int;		}		public function set x($val:int):void {			_cache.push( RoomLayerStateData.X, $val, _data.x, !_loaded );			update();		}		/**		* Y-position.		*/		public function get y():int {			return _cache.pull( RoomLayerStateData.Y, _data.y ) as int;		}		public function set y($val:int):void {			_cache.push( RoomLayerStateData.Y, $val, _data.y, !_loaded );			update();		}		/**		* X-coord of object's walk-to (floor) point.		*/		public function get mapX():int {			return _cache.pull( RoomLayerStateData.MAP_X, _data.mapX ) as int;		}		public function set mapX($val:int):void {			_cache.push( RoomLayerStateData.MAP_X, $val, _data.mapX, !_loaded );			update();		}		/**		* Y-coord of object's walk-to (floor) point.		*/		public function get mapY():int {			return _cache.pull( RoomLayerStateData.MAP_Y, _data.mapY ) as int;		}		public function set mapY($val:int):void {			_cache.push( RoomLayerStateData.MAP_Y, $val, _data.mapY, !_loaded );			update();		}		/**		* Turn view that a puppet should assume after walking to the object's map point.		*/		public function get mapTurnTo():int {			return _cache.pull( RoomLayerStateData.MAP_TURN, _data.turnTo ) as int;		}		public function set mapTurnTo($val:int):void {			_cache.push( RoomLayerStateData.MAP_TURN, $val, _data.turnTo, !_loaded );			update();		}		/**		* visibility of image asset display.		*/		public function get imageEnabled():Boolean {			return _cache.pull( RoomLayerStateData.IMAGE_ENABLED, _data.img ) as Boolean;		}		public function set imageEnabled($val:Boolean):void {			_cache.push( RoomLayerStateData.IMAGE_ENABLED, $val, _data.img, !_loaded );			update();		}		/**		* X-position of image asset.		*/		public function get imageX():int {			return _cache.pull( RoomLayerStateData.IMAGE_X, _data.imgX ) as int;		}		public function set imageX($val:int):void {			_cache.push( RoomLayerStateData.IMAGE_X, $val, _data.imgX, !_loaded );			update();		}		/**		* Y-position of image asset.		*/		public function get imageY():int {			return _cache.pull( RoomLayerStateData.IMAGE_Y, _data.imgY ) as int;		}		public function set imageY($val:int):void {			_cache.push( RoomLayerStateData.IMAGE_Y, $val, _data.imgY, !_loaded );			update();		}		/**		* horizontal scale of image asset.		*/		public function get imageScaleX():Number {			return _cache.pull( RoomLayerStateData.IMAGE_SCALE_X, _data.imgW ) as Number;		}		public function set imageScaleX($percent:Number):void {			_cache.push( RoomLayerStateData.IMAGE_SCALE_X, $percent, _data.imgW, !_loaded );			update();		}		/**		* vertical scale of image asset.		*/		public function get imageScaleY():Number {			return _cache.pull( RoomLayerStateData.IMAGE_SCALE_Y, _data.imgH ) as Number;		}		public function set imageScaleY($percent:Number):void {			_cache.push( RoomLayerStateData.IMAGE_SCALE_Y, $percent, _data.imgH, !_loaded );			update();		}		/**		* frame label of the layer's default display.		*/		public function get frameLabel():String {			return _cache.pull( RoomLayerStateData.FRAME_LABEL, _data.frame ) as String;		}		public function set frameLabel($val:String):void {			_cache.push( RoomLayerStateData.FRAME_LABEL, $val, _data.frame, !_loaded );			update();		}		/**		* Specifies a prefix to prepend onto all frame labels set for the state (puppet only).		*/		public function get framePrefix():String {			return _cache.pull( RoomLayerStateData.FRAME_PREFIX, _data.prefix ) as String;		}		public function set framePrefix($val:String):void {			_cache.push( RoomLayerStateData.FRAME_PREFIX, $val, _data.prefix, !_loaded );			update();		}		/**		* Frame label of the Lassie-triggered mouse-hover state display (puppet only).		*/		public function get hoverState():String {			return _cache.pull( RoomLayerStateData.HOVER_STATE, _data.hover ) as String;		}		public function set hoverState($val:String):void {			_cache.push( RoomLayerStateData.HOVER_STATE, $val, _data.hover, !_loaded );			update();		}		/**		* Frame label of the Lassie-triggered resting state display (puppet only).		*/		public function get restState():String {			return _cache.pull( RoomLayerStateData.REST_STATE, _data.rest ) as String;		}		public function set restState($val:String):void {			_cache.push( RoomLayerStateData.REST_STATE, $val, _data.rest, !_loaded );			update();		}		/**		* Frame label of the Lassie-triggered dialogue resting state display (puppet only).		*/		public function get diaRestState():String {			return _cache.pull( RoomLayerStateData.DIA_REST_STATE, _data.diaRest ) as String;		}		public function set diaRestState($val:String):void {			_cache.push( RoomLayerStateData.DIA_REST_STATE, $val, _data.diaRest, !_loaded );			update();		}		/**		* Frame label of the Lassie-triggered movement state display (puppet only).		*/		public function get moveState():String {			return _cache.pull( RoomLayerStateData.MOVE_STATE, _data.move ) as String;		}		public function set moveState($val:String):void {			_cache.push( RoomLayerStateData.MOVE_STATE, $val, _data.move, !_loaded );			update();		}		/**		* Frame label of the Lassie-triggered speaking state display (puppet only).		*/		public function get speakState():String {			return _cache.pull( RoomLayerStateData.SPEAK_STATE, _data.speak ) as String;		}		public function set speakState($val:String):void {			_cache.push( RoomLayerStateData.SPEAK_STATE, $val, _data.speak, !_loaded );			update();		}		/**		* Blend mode.		*/		public function get blendMode():String {			return _cache.pull( RoomLayerStateData.BLEND_MODE, _data.blend ) as String;		}		public function set blendMode($val:String):void {			_cache.push( RoomLayerStateData.BLEND_MODE, $val, _data.blend, !_loaded );			update();		}		/**		* Alpha (opacity).		*/		public function get alpha():Number {			return _cache.pull( RoomLayerStateData.ALPHA, _data.alpha ) as Number;		}		public function set alpha($val:Number):void {			_cache.push( RoomLayerStateData.ALPHA, $val, _data.alpha, !_loaded );			update();		}		/**		* Specifies if the layer image asset should be cached as a bitmap.		*/		public function get cacheAsBitmap():Boolean {			return _cache.pull( RoomLayerStateData.CACHE_AS_BITMAP, _data.bitmap ) as Boolean;		}		public function set cacheAsBitmap($enable:Boolean):void {			_cache.push( RoomLayerStateData.CACHE_AS_BITMAP, $enable, _data.bitmap, !_loaded );			update();		}		/**		* Enabled status of the layer hitarea.		*/		public function get hitEnabled():Boolean {			return _cache.pull( RoomLayerStateData.HIT_ENABLED, _data.hit ) as Boolean;		}		public function set hitEnabled($val:Boolean):void {			_cache.push( RoomLayerStateData.HIT_ENABLED, $val, _data.hit, !_loaded );			update();		}		/**		* X-position of the hit area within layer coordinates.		*/		public function get hitX():int {			return _cache.pull( RoomLayerStateData.HIT_X, _data.hitX ) as int;		}		public function set hitX($val:int):void {			_cache.push( RoomLayerStateData.HIT_X, $val, _data.hitX, !_loaded );			update();		}		/**		* Y-position of the hit area within layer coordinates.		*/		public function get hitY():int {			return _cache.pull( RoomLayerStateData.HIT_Y, _data.hitY ) as int;		}		public function set hitY($val:int):void {			_cache.push(  RoomLayerStateData.HIT_Y, $val, _data.hitY, !_loaded );			update();		}		/**		* Width of the layer hit area.		*/		public function get hitWidth():int {			return _cache.pull( RoomLayerStateData.HIT_WIDTH, _data.hitW ) as int;		}		public function set hitWidth($val:int):void {			_cache.push( RoomLayerStateData.HIT_WIDTH, $val, _data.hitW, !_loaded );			update();		}		/**		* Height of the layer hit area.		*/		public function get hitHeight():int {			return _cache.pull( RoomLayerStateData.HIT_HEIGHT, _data.hitH ) as int;		}		public function set hitHeight($val:int):void {			_cache.push( RoomLayerStateData.HIT_HEIGHT, $val, _data.hitH, !_loaded );			update();		}		/**		* Shape of the layer hit area.		*/		public function get hitShape():String {			return _cache.pull( RoomLayerStateData.HIT_SHAPE, _data.shape ) as String;		}		public function set hitShape($val:String):void {			_cache.push( RoomLayerStateData.HIT_SHAPE, $val, _data.shape, !_loaded );			update();		}		/**		* rotation of the display, in degrees.		*/		public function get rotation():int {			return _cache.pull( RoomLayerStateData.ROTATION, _data.rotate ) as int;		}		public function set rotation($val:int):void {			_cache.push( RoomLayerStateData.ROTATION, $val, _data.rotate, !_loaded );			update();		}		/**		* Specifies if float sorting is enabled (puppet/plane only).		*/		public function get floatEnabled():Boolean {			return _cache.pull( RoomLayerStateData.FLOAT_ENABLED, _data.float ) as Boolean;		}		public function set floatEnabled($enable:Boolean):void {			_cache.push( RoomLayerStateData.FLOAT_ENABLED, $enable, _data.float, !_loaded );			update();		}		/**		* Specifies if mouse response is enabled (puppet/plane/bg only).		*/		public function get mouseEnabled():Boolean {			return _cache.pull( RoomLayerStateData.MOUSE_ENABLED, _data.mouse ) as Boolean;		}		public function set mouseEnabled($enable:Boolean):void {			_cache.push( RoomLayerStateData.MOUSE_ENABLED, $enable, _data.mouse, !_loaded );			update();		}		/**		* Specifies the cursor frame label to display on rollover (puppet only).		*/		public function get hoverCursor():String {			return _cache.pull( RoomLayerStateData.CURSOR_FRAME, _data.cursor ) as String;		}		public function set hoverCursor($val:String):void {			_cache.push( RoomLayerStateData.CURSOR_FRAME, $val, _data.cursor, !_loaded );			update();		}		/**		* Specifies the color of the layer's dialogue subtitle. (puppet only).		*/		public function get subtitleColor():uint {			return _cache.pull( RoomLayerStateData.SUBTITLE_COLOR, _data.subtitle ) as uint;		}		public function set subtitleColor($val:uint):void {			_cache.push( RoomLayerStateData.SUBTITLE_COLOR, $val, _data.subtitle, !_loaded );			update();		}		/**		* Specifies number of pixels moved per frame while dynamically tweening (puppet only).		*/		public function get tweenRate():Number {			return _cache.pull( RoomLayerStateData.TWEEN_RATE, _data.tween ) as Number;		}		public function set tweenRate($val:Number):void {			_cache.push( RoomLayerStateData.TWEEN_RATE, $val, _data.tween, !_loaded );			update();		}		/**		* Specifies the index of a layer action to call automatically upon mouse click (puppet only). Specify -1 for no action.		*/		public function get clickAction():int {			return _cache.pull( RoomLayerStateData.CLICK_ACTION, _data.onclick ) as int;		}		public function set clickAction($val:int):void {			_cache.push( RoomLayerStateData.CLICK_ACTION, $val, _data.onclick, !_loaded );			update();		}		/**		* Specifies the layer's directional view setting, expressed as a number between 1-8 (puppet only).		*/		public function get turnView():int {			return _cache.pull( RoomLayerStateData.TURN_VIEW, _data.turn ) as int;		}		public function set turnView($val:int):void {			_cache.push( RoomLayerStateData.TURN_VIEW, $val, _data.turn, !_loaded );			update();		}		/**		* Specifies a matrix scale filter to apply to the layer display (puppet only).		*/		public function get scaleFilter():String {			return _cache.pull( RoomLayerStateData.SCALE_FILTER, _data.scale ) as String;		}		public function set scaleFilter($val:String):void {			_cache.push( RoomLayerStateData.SCALE_FILTER, $val, _data.scale, !_loaded );			update();		}		/**		* Specifies a matrix color filter to apply to the layer display (puppet only).		*/		public function get colorFilter():String {			return _cache.pull( RoomLayerStateData.COLOR_FILTER, _data.color ) as String;		}		public function set colorFilter($val:String):void {			_cache.push( RoomLayerStateData.COLOR_FILTER, $val, _data.color, !_loaded );			update();		}		/**		* Specifies a matrix tween-rate modifier filter to apply to the layer display (puppet only).		*/		public function get rateFilter():String {			return _cache.pull( RoomLayerStateData.RATE_FILTER, _data.rate ) as String;		}		public function set rateFilter($val:String):void {			_cache.push( RoomLayerStateData.RATE_FILTER, $val, _data.rate, !_loaded );			update();		}		/**		* Specifies a matrix blur filter to apply to the layer display (puppet only).		*/		public function get blurFilter():String {			return _cache.pull( RoomLayerStateData.BLUR_FILTER, _data.blur ) as String;		}		public function set blurFilter($val:String):void {			_cache.push( RoomLayerStateData.BLUR_FILTER, $val, _data.blur, !_loaded );			update();		}		/**		* Specifies if movement by the layer should trigger room scrolling (puppet only).		*/		public function get scrollEnabled():Boolean {			return _cache.pull( RoomLayerStateData.SCROLL_ENABLED, _data.scroller ) as Boolean;		}		public function set scrollEnabled($enable:Boolean):void {			_cache.push( RoomLayerStateData.SCROLL_ENABLED, $enable, _data.scroller, !_loaded );			update();		}		/**		* Specifies if parallax scroll tracking is enabled (plane only).		*/		public function get parallaxAxis():String {			return _cache.pull( RoomLayerStateData.PARALLAX_AXIS, _data.parallax ) as String;		}		public function set parallaxAxis($axis:String):void {			_cache.push( RoomLayerStateData.PARALLAX_AXIS, $axis, _data.parallax, !_loaded );			update();		}		/**		* Left scroll margin of the room bounds (background only).		*/		public function get scrollMarginLeft():int {			return _cache.pull( RoomLayerStateData.SCROLL_LEFT, _data.scrollL ) as int;		}		public function set scrollMarginLeft($val:int):void {			_cache.push( RoomLayerStateData.SCROLL_LEFT, $val, _data.scrollL, !_loaded );			update();		}		/**		* Right scroll margin of the room bounds (background only).		*/		public function get scrollMarginRight():int {			return _cache.pull( RoomLayerStateData.SCROLL_RIGHT, _data.scrollR ) as int;		}		public function set scrollMarginRight($val:int):void {			_cache.push( RoomLayerStateData.SCROLL_RIGHT, $val, _data.scrollR, !_loaded );			update();		}		/**		* Top scroll margin of the room bounds (background only).		*/		public function get scrollMarginTop():int {			return _cache.pull( RoomLayerStateData.SCROLL_TOP, _data.scrollT ) as int;		}		public function set scrollMarginTop($val:int):void {			_cache.push( RoomLayerStateData.SCROLL_TOP, $val, _data.scrollT, !_loaded );			update();		}		/**		* Bottom scroll margin of the room bounds (background only).		*/		public function get scrollMarginBottom():int {			return _cache.pull( RoomLayerStateData.SCROLL_BOTTOM, _data.scrollB ) as int;		}		public function set scrollMarginBottom($val:int):void {			_cache.push( RoomLayerStateData.SCROLL_BOTTOM, $val, _data.scrollB, !_loaded );			update();		}	}}import flash.display.BlendMode;import com.lassie.player.room.HitAreaShape;import com.lassie.player.room.ParallaxAxis;import com.lassie.player.model.ActionList;final internal class RoomLayerStateData extends Object{//-------------------------------------------------// Layer display-state frame labels//-------------------------------------------------	static public const REST_STATE:String = "rest";	static public const MOVE_STATE:String = "move";	static public const SPEAK_STATE:String = "speak";	static public const DIA_REST_STATE:String = "diaRest";	static public const HOVER_STATE:String = "hover";//-------------------------------------------------// State field names (abbreviated from main API)//-------------------------------------------------	static public const TITLE:String = "title";	static public const X:String = "x";	static public const Y:String = "y";	static public const MAP_X:String = "mapX";	static public const MAP_Y:String = "mapY";	static public const MAP_TURN:String = "turnTo";	static public const IMAGE_ENABLED:String = "img";	static public const IMAGE_X:String = "imgX";	static public const IMAGE_Y:String = "imgY";	static public const IMAGE_SCALE_X:String = "imgW";	static public const IMAGE_SCALE_Y:String = "imgH";	static public const FRAME_LABEL:String = "frame";	static public const FRAME_PREFIX:String = "prefix";	static public const BLEND_MODE:String = "blend";	static public const ALPHA:String = "alpha";	static public const CACHE_AS_BITMAP:String = "bitmap";	static public const HIT_ENABLED:String = "hit";	static public const HIT_X:String = "hitX";	static public const HIT_Y:String = "hitY";	static public const HIT_WIDTH:String = "hitW";	static public const HIT_HEIGHT:String = "hitH";	static public const HIT_SHAPE:String = "shape";	static public const CURSOR_FRAME:String = "cursor";	static public const MOUSE_ENABLED:String = "mouse";	static public const FLOAT_ENABLED:String = "float";	static public const SUBTITLE_COLOR:String = "subtitle";	static public const TWEEN_RATE:String = "tween";	static public const CLICK_ACTION:String = "onclick";	static public const TURN_VIEW:String = "turn";	static public const ROTATION:String = "rotate";	static public const SCALE_FILTER:String = "scale";	static public const COLOR_FILTER:String = "color";	static public const RATE_FILTER:String = "rate";	static public const BLUR_FILTER:String = "blur";	static public const PARALLAX_AXIS:String = "parallax";	static public const SCROLL_ENABLED:String = "scroller";	static public const SCROLL_LEFT:String = "scrollL";	static public const SCROLL_RIGHT:String = "scrollR";	static public const SCROLL_TOP:String = "scrollT";	static public const SCROLL_BOTTOM:String = "scrollB";//-------------------------------------------------// State data fields//-------------------------------------------------	// core properties	public var id:String;	public var title:XML;	public var x:int = 0;	public var y:int = 0;	public var mapX:int = 0;	public var mapY:int = 0;	public var turnTo:int = 5;	// layer state frame labels	public var rest:String = RoomLayerStateData.REST_STATE;	public var move:String = RoomLayerStateData.MOVE_STATE;	public var speak:String = RoomLayerStateData.SPEAK_STATE;	public var diaRest:String = RoomLayerStateData.REST_STATE;	// layer image properties	public var img:Boolean = true;	public var imgX:int = 0;	public var imgY:int = 0;	public var imgW:Number = 1;	public var imgH:Number = 1;	public var frame:String = "";	public var hover:String = "";	public var prefix:String = "";	public var blend:String = BlendMode.NORMAL;	public var alpha:Number = 1;	public var bitmap:Boolean = false;	// layer hitarea properties	public var hit:Boolean = true;	public var hitX:int = 0;	public var hitY:int = 0;	public var hitW:int = 0;	public var hitH:int = 0;	public var shape:String = HitAreaShape.RECT;	// layer params	public var cursor:String = "";	public var mouse:Boolean = true;	public var float:Boolean = false;	public var subtitle:Number = 0xFFFFFF;	public var tween:Number = 0;	public var onclick:int = 0;	public var turn:int = 0;	public var rotate:int = 0;	// layer filters	public var scale:String = "";	public var color:String = "";	public var rate:String = "";	public var blur:String = "";	public var parallax:String = ParallaxAxis.NONE;	public var scroller:Boolean = false;	public var scrollL:int = 0;	public var scrollR:int = 0;	public var scrollT:int = 0;	public var scrollB:int = 0;	// actions	public var actions:ActionList;	public var itemActions:ActionList;	public var actionProps:XML;	public function RoomLayerStateData():void	{		super();		actions = new ActionList();		itemActions = new ActionList();	}}