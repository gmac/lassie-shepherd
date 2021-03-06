/**
* Lassie Engine Game Player
* @author Greg MacWilliam.
*/
package com.lassie.player.geom
{
	import flash.geom.Point;
	import flash.geom.ColorTransform;

	final public class GeomUtil
	{
		/**
		* Calulates the distance between two points.
		* @param $start the start point of the line.
		* @param $end the end point of the line.
		* @return distance between the two points.
		*/
		static public function distance($start:Point, $end:Point):Number
		{
			var $a:Number = $start.x-$end.x;
			var $b:Number = $start.y-$end.y;
			return Math.sqrt(($a * $a) + ($b * $b));
		}

		/**
		* Converts degrees into radians.
		* @param $degrees: number of degrees.
		* @return radians equivalent.
		*/
		static public function degreesToRadians($degrees:Number):Number {
			return $degrees * Math.PI / 180;
		}

		/**
		* Converts radians into degrees.
		* @param $radians: number of radians.
		* @return degrees equivalent.
		*/
		static public function radiansToDegrees($radians:Number):Number {
			return $radians * 180 / Math.PI;
		}

		/**
		* Calulates the angle between two points in radians.
		* @param $start: the start point.
		* @param $end: the end point.
		* @return angle (in radians).
		*/
		static public function angleRadians($start:Point, $end:Point):Number {
			return Math.atan2($end.y-$start.y, $end.x-$start.x);
		}

		/**
		* Calulates the angle between two points in degrees.
		* @param $start: the start point.
		* @param $end: the end point.
		* @return angle (in degrees).
		*/
		static public function angleDegrees($start:Point, $end:Point):Number {
			var $degrees:Number = radiansToDegrees( angleRadians($start, $end) );
			return ($degrees < 0) ? 360 + $degrees : $degrees;
		}

		/**
		* Calulates a puppet layer turn view: 360-degree >> 1-8 view
		* A turn view expresses one of the 8 directional states that a puppet may assume:
		* Back, BackQR, SideR, FrontQR, Front, FrontQL, SideL, BackQL
		* @param $degrees: angle (in degrees: 0-360)
		* @return 1-8 view
		*/
		static public function turnView($degrees:Number):int
		{
			// offset degrees to align the zero-mark with the vertical axis.
			$degrees-=(180 + 45 + 23);

			// adjust degrees to fall within range of a circle.
			if ($degrees < 0) {
				$degrees+=360;
			}
			else if ($degrees > 360) {
				$degrees-=360;
			}
			return Math.ceil(($degrees / 360) * 8);
		}

		/**
		* Offsets a base point in the direction of a given turn view.
		* @param $base: the base point to offset.
		* @param $turnView: the turn view direction (1-8) by which to offset the point.
		* @return the offset point.
		*/
		static public function turnOffset($base:Point, $turnView:int):Point
		{
			var $offset:Point;

			switch ($turnView) {
				case 1: $offset = new Point(0, -1); break;
				case 2: $offset = new Point(1, -1); break;
				case 3: $offset = new Point(1, 0); break;
				case 4: $offset = new Point(1, 1); break;
				case 5: $offset = new Point(0, 1); break;
				case 6: $offset = new Point(-1, 1); break;
				case 7: $offset = new Point(-1, 0); break;
				case 8: $offset = new Point(-1, -1); break;
			}
			return $base.add($offset);
		}

		/**
		* Calulates the increment for moving between two points at a set rate.
		* @param $start: the start point.
		* @param $end: the end point.
		* @param $rate: rate of movement (in total pixels).
		* @return a point with x and y position modifiers.
		*/
		static public function angleIncrement($start:Point, $end:Point, $rate:Number):Point
		{
			var $inc:Point = new Point(0, 0);
			var $radians:Number = angleRadians($start, $end);
			$inc.x = $rate * Math.cos($radians);
			$inc.y = $rate * Math.sin($radians);
			return $inc;
		}

		/**
		* Rotates a Point around another Point by the specified angle.
		* @param $point: the Point to rotate.
		* @param $center: the Point to rotate around.
		* @param $degrees: the angle (in degrees) to rotate this point.
		* @return the adjusted orbit point.
		*/
		static public function orbit($point:Point, $center:Point, $degrees:Number):Point
		{
			var $radians:Number = degreesToRadians($degrees);
			var $baseX:Number = $point.x - $center.x;
			var $baseY:Number = $point.y - $center.y;
			var $adjusted:Point = $point.clone();

			$adjusted.x = (Math.cos($radians) * $baseX) - (Math.sin($radians) * $baseY) + $center.x;
			$adjusted.y = (Math.sin($radians) * $baseX) + (Math.cos($radians) * $baseY) + $center.y;
			return $adjusted;
		}

		/**
		* Scales a point by the specified percentage.
		* @param $point: point to scale.
		* @param $percent: percentage to adjust the coordinates by.
		* @return a new point scaled to the specified percentage.
		*/
		static public function scalePoint($point:Point, $percent:Number):Point {
			return new Point($point.x * $percent, $point.y * $percent);
		}

		/**
		* Calculates a mid-point value at a specific percentage between a starting and ending value.
		* @param start  Starting value.
		* @param end  Ending value.
		* @param percent  Percentage between starting and ending values at which to plot the interpolated value.
		* @return The interpolated value.
		*/
		static public function interpolate($min:Number, $max:Number, $percent:Number):Number {
			return $min + ($max - $min) * $percent;
		}

		/**
		* Calculates a mid-point ColorTransform at a specific percentage between a start and end ColorTransform.
		* @param start  Start-point ColorTransform.
		* @param end  End-point ColorTransform.
		* @param percent  Percentage between start and end point at which to plot the interpolated transform.
		* @return The interpolated ColorTransform.
		*/
		static public function interpolateColor($start:ColorTransform, $end:ColorTransform, $percent:Number):ColorTransform
		{
			var $mid:ColorTransform = new ColorTransform();
			$mid.redMultiplier = interpolate($start.redMultiplier, $end.redMultiplier, $percent);
			$mid.greenMultiplier = interpolate($start.greenMultiplier, $end.greenMultiplier, $percent);
			$mid.blueMultiplier = interpolate($start.blueMultiplier, $end.blueMultiplier, $percent);
			$mid.alphaMultiplier = interpolate($start.alphaMultiplier, $end.alphaMultiplier, $percent);
			$mid.redOffset = interpolate($start.redOffset, $end.redOffset, $percent);
			$mid.greenOffset = interpolate($start.greenOffset, $end.greenOffset, $percent);
			$mid.blueOffset = interpolate($start.blueOffset, $end.blueOffset, $percent);
			$mid.alphaOffset = interpolate($start.alphaOffset, $end.alphaOffset, $percent);
			return $mid;
		}

		/**
		* Copies a ColorTransform object as a new ColorTransform instance.
		* @param ColorTransform  The ColorTransform instance to clone.
		* @return The clone.
		*/
		static public function copyColorTransform($c:ColorTransform):ColorTransform
		{
			return new ColorTransform(
				$c.redMultiplier,
				$c.greenMultiplier,
				$c.blueMultiplier,
				$c.alphaMultiplier,
				$c.redOffset,
				$c.greenOffset,
				$c.blueOffset,
				$c.alphaOffset
			);
		}
	}
}
