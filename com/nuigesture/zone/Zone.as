package com.nuigesture.zone
{
	public class Zone
	{
		private var _zonename:String;
		private var _startDistand:int;
		private var _endDistand:int;
		public function Zone(zonename:String ,startDistand:Number ,endDistand:Number )
		{
			_zonename = zonename;
			_startDistand = startDistand;
			_endDistand = endDistand;
		}
		public function get startDistand():Number
		{
			return _startDistand;
		}
		public function get endDistand():Number
		{
			return _endDistand;
		}
		public function get zoneName():String
		{
			return _zonename;
		}
	}
}