package com.nuigesture.action
{
	public class ActionPoint
	{
		private var _rgbX:int=0;
		private var _rgbY:int=0;
		private var _worldX:int=0;
		private var _worldY:int=0;
		private var _worldZ:int=0;
		private var _az:int=0;
		public function ActionPoint(z:Number ,rx:Number =0,ry:Number =0,wx:Number=0 ,wy:Number=0 ,wz:Number=0)
		{
			_az = z;
			_rgbX = rx;
			_rgbY = ry;
			_worldX = wx;
			_worldY = wy;
			_worldZ = wz;
		}
		public function toString():String {
			var s:String =""
			s+="az:"+_az+"\n"
			s+="rx:"+_rgbX+"\n"
			s+="ry:"+_rgbY+"\n"
			s+="wx:"+_worldX+"\n"
			s+="wy:"+_worldY+"\n"
			s+="wz:"+_worldZ+"\n"
			return s
		}
		public function get az():int
		{
			return _az;
		}
		public function get rgbX():int
		{
			return _rgbX;
		}
		public function get rgbY():int
		{
			return _rgbY;
		}
		public function get worldX():int
		{
			return _worldX;
		}
		public function get worldY():int
		{
			return _worldY;
		}
		public function get worldZ():int
		{
			return _worldZ;
		}
	}
}