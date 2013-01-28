package com.nuigesture.manager
{
	import flash.geom.Vector3D;
	import com.nuigesture.zone.Zone;
	import com.nuigesture.core.NuiSettings;
	public class ZoneManager
	{
		private static var _ignoreZone:Zone;
		private static var _gestureZone:Zone;
		private static var _controlZone:Zone;
		private static var _selectionZone:Zone;
		private static var zoneArray:Array;
		private static var arrayLength:uint;
		public static const ignoreZone:String = "igonere";
		public static const gestureZone:String = "gesture";
		public static const controlZone:String = "control";
		public static const selectionZone:String = "selection";
		public static function init()
		{
			/*_ignoreZone = new Zone("igonere",-600,100);
			_gestureZone = new Zone("gesture",150,450);
			_controlZone = new Zone("control",450,630);
			_selectionZone = new Zone("selection",580,900);*/
			_ignoreZone = new Zone("igonere",-600,NuiSettings.ZoneIgnoreLimit);
			_gestureZone = new Zone("gesture",NuiSettings.ZoneIgnoreLimit,NuiSettings.ZoneGestureLimit);
			_controlZone = new Zone("control",NuiSettings.ZoneGestureLimit,NuiSettings.ZoneControlLimit);
			_selectionZone = new Zone("selection",NuiSettings.ZoneControlLimit,NuiSettings.ZoneSelectionLimit);
			zoneArray = new Array  ;
			zoneArray.push(_ignoreZone);
			zoneArray.push(_gestureZone);
			zoneArray.push(_controlZone);
			zoneArray.push(_selectionZone);
			arrayLength = 4;
			trace("ZoneManager:initialized");
		}
		public static function searchInZone(handDistand:Number):String
		{
			var returnString:String;
			for (var i:int =1; i<arrayLength; i++)
			{
				//zoneArray[i].endDistand;
				if (zoneArray[i].endDistand > handDistand)
				{
					return zoneArray[i].zoneName;
				}
			}
			return "outofrange";
		}
		public static function dispose()
		{
			zoneArray = null;
			_ignoreZone = null;
			_gestureZone = null;
			_controlZone = null;
			_selectionZone = null;
		}
	}
}