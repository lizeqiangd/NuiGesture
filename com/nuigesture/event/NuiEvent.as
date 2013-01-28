package com.nuigesture.event
{
	import flash.events.Event;
	public class NuiEvent extends Event
	{
		public static var ACTION_CAPTURED:String = "action_captured";
		public var data:*;
		public function NuiEvent(type:String,DispatchData:* = null,bubbles:Boolean = false)
		{
			super(type,bubbles);
			data = DispatchData;
		}
	}
}