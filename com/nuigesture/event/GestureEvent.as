package com.nuigesture.event
{
	import flash.events.Event;
	public class GestureEvent extends Event
	{
		public static var GESTURE:String = "gesture";
		public var data:*;
		public function GestureEvent(type:String,DispatchData:* = null,bubbles:Boolean = false)
		{
			super(type,bubbles);
			data = DispatchData;
		}
	}
}