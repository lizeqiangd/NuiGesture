package com.nuigesture.core
{
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import flash.geom.Vector3D;
	import flash.geom.Point;

	public class HandDistand
	{
		private static var _leftHandDistand:Number;
		private static var _rightHandDistand:Number;
		public static function set user(e:User )
		{
			//trace("HandDistand:user 已经收到正在计算");
			calculating(e.head.position.world,e.leftShoulder.position.world,e.rightShoulder.position.world,e.leftHand.position.world,e.rightHand.position.world);

		}
		private static function calculating(head:Vector3D,left:Vector3D,right:Vector3D,leftHand:Vector3D,rightHand:Vector3D)
		{
			/*var k:Number =(head.y-((left.y + right.y)/2))/(head.z-((left.z + right.z)/2));
			var b:Number = head.y - head.x * k;
			tx_calculating.text = "y=" + k + "z+" + b;
			tx_calculating.text +="\nY:"+(head.y-((left.y + right.y)/2));
			tx_calculating.text +="\nZ:"+(head.z-((left.z + right.z)/2));
			var b2:Number = rightHand.y - rightHand.x * k;
			//Math.PI/2-Math.atan(k)
			var angle:Number = Math.PI / 2 - Math.atan(k);
			var realangle:Number = angle / Math.PI * 180;
			tx_calculating.text +=  "\n补角:" + realangle;
			var hand:Number = (b - b2) * Math.sin(angle);
			tx_calculating.text +=  "\nHand:" + hand;
			tx_calculating.text = "";*/
			var p1:Point = new Point(head.z,head.y);
			var p2:Point = new Point((left.z+right.z)/2,(left.y+right.y)/2);
			//trace(p1,p2)
			var k:Number =(p1.y-p2.y)/(p1.x-p2.x);
			var b:Number = p1.y - p1.x * k;
			//trace("y="+k+"x+("+b+")");
			var p3:Point = new Point(rightHand.z,rightHand.y);
			var b3:Number = p3.y - p3.x * k;
			_rightHandDistand =Math.sin (Math.PI/2-Math.atan(k))*Math.abs (b-b3);
			_rightHandDistand = Math.round(_rightHandDistand);
			var p4:Point = new Point(leftHand.z,leftHand.y);
			var b4:Number = p4.y - p4.x * k;
			_leftHandDistand =Math.sin (Math.PI/2-Math.atan(k))*Math.abs (b-b4);
			_leftHandDistand = Math.round(_leftHandDistand);
			//tx_calculating.text = "y=" + k + "z+" + b;
			//tx_calculating.text +=  "\nHand:" + distand;
			//trace("HandDistand:l:"+_leftHandDistand+" r:"+_rightHandDistand);

		}
		public static function get leftHandDistand():Number
		{
			return _leftHandDistand;
		}
		public static function get rightHandDistand():Number
		{
			return _rightHandDistand;
		}
	}
}