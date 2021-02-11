/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	import flash.filters.BlurFilter;

	final public class Filter extends Object
	{
		// public
		public var enabled:Boolean = true;

		// private
		private var _id:String = "";
		private var _axis:String = FilterAxis.Y;
		private var _alpha:FilterPole;
		private var _omega:FilterPole;

		public function Filter($id:String, $axis:String):void
		{
			super();
			_id = $id;
			_alpha = new FilterPole();
			_omega = new FilterPole();
			if (FilterAxis.validate($axis)) _axis = $axis;
		}

		/**
		* Destroys the filter to optimize for garbage collection.
		*/
		public function destroy():void {
			_alpha = null;
			_omega = null;
		}

		/**
		* Traces a Filter object to string.
		*/
		public function toString():String {
			return "[Filter] id: "+ id +", alpha: "+ _alpha +", omega: "+ _omega;
		}

		/**
		* [static] parses an XML structure into a new Filter object.
		*/
		static public function parseXML($xml:XML):Filter
		{
			var $alpha:XML = XML($xml.pole[0]);
			var $omega:XML = XML($xml.pole[1]);
			var $filter:Filter = new Filter($xml.@id, $xml.@axis);
			$filter.enabled = $xml.@enabled;
			$filter.alphaPole = new FilterPole($alpha.@x, $alpha.@y, $alpha);
			$filter.omegaPole = new FilterPole($omega.@x, $omega.@y, $omega);
			return $filter;
		}

	//-------------------------------------------------
	// READ-ONLY
	//-------------------------------------------------

		/**
		* Defines the Id of the filter.
		*/
		public function get id():String {
			return _id;
		}

		/**
		* Defines the axis of this filter.
		*/
		public function get axis():String {
			return _axis;
		}

	//-------------------------------------------------
	// Pole accessors
	//-------------------------------------------------

		/**
		* Specifies the filter pole assigned to the minimum / inner pole of the matrix.
		*/
		public function get alphaPole():FilterPole {
			return _alpha;
		}
		public function set alphaPole($pole:FilterPole):void {
			if ($pole != null) _alpha = $pole;
		}

		/**
		* Specifies the filter pole assigned to the maximum / outer pole of the matrix.
		*/
		public function get omegaPole():FilterPole {
			return _omega;
		}
		public function set omegaPole($pole:FilterPole):void {
			if ($pole != null) _omega = $pole;
		}

	//-------------------------------------------------
	// Scale filter
	//-------------------------------------------------

		/**
		* Returns an interpolated scale value based on supplied point.
		*/
		public function getScale($point:Point):Number
		{
			if (enabled) {
				return _interpolateValue(_alpha.scale, _omega.scale, $point);
			}
			return Filter.clearScale();
		}

		/**
		* [static] Nullifies all previous scale adjustments.
		*/
		static public function clearScale():Number {
			return 1;
		}

	//-------------------------------------------------
	// Rate filter
	//-------------------------------------------------

		/**
		* Returns an interpolated speed value based on supplied point.
		*/
		public function getRate($point:Point):Number
		{
			if (enabled) {
				return _interpolateValue(_alpha.rate, _omega.rate, $point);
			}
			return Filter.clearRate();
		}

		/**
		* [static] Nullifies all previous speed adjustments.
		*/
		static public function clearRate():Number {
			return 1;
		}

	//-------------------------------------------------
	// Color filter
	//-------------------------------------------------

		/**
		* Returns an interpolated color transform based on supplied point.
		*/
		public function getColor($point:Point):ColorTransform
		{
			if (enabled) {
				return GeomUtil.interpolateColor(_alpha.color, _omega.color, _plotMatrixPoint($point));
			}
			return Filter.clearColor();
		}

		/**
		* [static] Nullifies all previous color adjustments.
		*/
		static public function clearColor():ColorTransform {
			return new ColorTransform();
		}

	//-------------------------------------------------
	// Blur filter
	//-------------------------------------------------

		/**
		* Returns an interpolated blur filter based on supplied point.
		*/
		public function getBlur($point:Point):BlurFilter
		{
			if (enabled) {
				var $blur:Number = _interpolateValue(_alpha.blur, _omega.blur, $point);
				return new BlurFilter($blur, $blur, 2);
			}
			return Filter.clearBlur();
		}

		/**
		* [static] Nullifies all previous blur adjustments.
		*/
		static public function clearBlur():BlurFilter {
			return null;
		}

	//-------------------------------------------------
	// Utility methods
	//-------------------------------------------------

		/**
		* Calculates a percentage based on a point's position within the matrix geometry.
		*/
		private function _plotMatrixPoint($point:Point):Number
		{
			var $total:Number = 0;
			var $actual:Number = 0;

			if (_axis == FilterAxis.RADIAL)
			{
				// Radial axis
				// calculate all values relative to minimum pole.
				$total = Point.distance(_alpha, _omega);
				$actual = Point.distance(_alpha, $point);
			}
			else
			{
				// X or Y axis
				// calculate values based on current position between poles.
				$total = _alpha[_axis] - _omega[axis];
				$actual = _alpha[_axis] - $point[axis];
			}

			// calculate percentage of distance traveled between points.
			var $percent:Number = $actual/$total;
			if (isNaN($percent)) $percent = 1;

			// return percentage value between 0 and 1.
			return Math.max(0, Math.min($percent, 1));
		}

		/**
		* Interpolates a numeric value based on a point within the matrix.
		*/
		private function _interpolateValue($alpha:Number, $omega:Number, $point:Point):Number {
			return GeomUtil.interpolate($alpha, $omega, _plotMatrixPoint($point));
		}
	}
}
