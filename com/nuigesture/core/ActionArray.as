package com.nuigesture.core
{
	import com.nuigesture.action.ActionPoint;
	import flash.events.EventDispatcher;
	import com.nuigesture.event.NuiEvent;
	import com.nuigesture.NuiGesture;

	public class ActionArray
	{
		public var _ActionArrayNodeName:String;
		public var _ActionArrayLength:uint = 3;
		//private var _eventDispatch:EventDispatcher;
		private var _UserNodeId:uint;
		private var _CentrePoint:ActionPoint;
		private var _CentrePoint1:ActionPoint;
		private var _CentrePoint2:ActionPoint;
		private var _CentrePoint3:ActionPoint;
		private var _nowCount:uint = 0;
		private var _ActionPoint1:ActionPoint;
		private var _ActionPoint2:ActionPoint;
		private var _ActionPoint3:ActionPoint;
		private var _SelectPoint:uint;
		private var _Inited:Boolean = false;
		private var _z:int = 0;
		public var isAnalysis:Boolean = false;
		public function ActionArray(ActionArrayNodeName:String /*,UserNodeId:uint*/,ActionArrayLength:uint=3)
		{
			_ActionArrayNodeName = ActionArrayNodeName;
			//_UserNodeId = UserNodeId;
			_ActionArrayLength = ActionArrayLength;
			_SelectPoint = 0;
			_z = 0;
			//_eventDispatch=new EventDispatcher ();
		}
		/*public function addEventListener(type,listener,userCapture=false,priority=0,userWeakReference=false)
		{
		if (! _eventDispatch.hasEventListener(type))
		{
		_eventDispatch.addEventListener(type,listener,userCapture,priority,userWeakReference);
		}
		
		}
		public function removeEventListener(type,listener,userCapture=false)
		{
		if (_eventDispatch.hasEventListener(type))
		{
		_eventDispatch.removeEventListener(type,listener,userCapture);
		}
		
		}*/
		public function capture(action:ActionPoint,centrepoint:ActionPoint)
		{
			if (! _Inited)
			{
				//trace("ActionArray["+_ActionArrayNodeName+"]initing...")
				_ActionPoint1 = action;
				_ActionPoint2 = action;
				_ActionPoint3 = action;
				addCentrePoint(centrepoint);
				addCentrePoint(centrepoint);
				addCentrePoint(centrepoint);
				_Inited = true;
			}
			addCentrePoint(centrepoint);
			_nowCount == 3 ? _nowCount = 1:_nowCount++;
			this["_ActionPoint" + _nowCount] = action;
			calculateCenterPoint();
			calculateZ();
			isAnalysis?analysis():null
			//_eventDispatch.dispatchEvent(new NuiEvent (NuiEvent.ACTION_CAPTURED,this));

		}private function analysis( ){
			ActionAnalysis.analysis(this)
		}
		public function dispose()
		{
			_CentrePoint = null;
			_CentrePoint1 = null;
			_CentrePoint2 = null;
			_CentrePoint3 = null;
			_ActionPoint1 = null;
			_ActionPoint2 = null;
			_ActionPoint3 = null;
			//_eventDispatch = null;
		}
		private function addCentrePoint(e:ActionPoint )
		{
			_SelectPoint == 3 ? _SelectPoint = 1:_SelectPoint++;
			this["_CentrePoint" + _SelectPoint] = e;
		}
		private function calculateCenterPoint()
		{
			var az:Number = 0;// _CentrePoint1.az + _CentrePoint2.az + _CentrePoint3.az;
			var rx:Number = _CentrePoint1.rgbX + _CentrePoint2.rgbX + _CentrePoint3.rgbX;
			var ry:Number = _CentrePoint1.rgbY + _CentrePoint2.rgbY + _CentrePoint3.rgbY;
			var wx:Number = _CentrePoint1.worldX + _CentrePoint2.worldX + _CentrePoint3.worldX;
			var wy:Number = _CentrePoint1.worldY + _CentrePoint2.worldY + _CentrePoint3.worldY;
			var wz:Number = _CentrePoint1.worldZ + _CentrePoint2.worldZ + _CentrePoint3.worldZ;
			_CentrePoint=new ActionPoint(az/3,rx/3,ry/3,wx/3,wy/3,wz/3);
			//trace("ActionArray["+_ActionArrayNodeName+"]CentrePoint")
			//trace(_CentrePoint.toString ())
			//trace("***********END**************")
		}
		private function calculateZ()
		{
			_z=(_ActionPoint1.az+_ActionPoint2.az+_ActionPoint3.az)/3;
		}
		public function get z():int
		{
			return _z;
		}
		public function get centrePoint():ActionPoint
		{
			return _CentrePoint;
		}
		public function clean()
		{
			_Inited = false;
		}
		public function getActionPoint(i:uint ):ActionPoint
		{
			if (i==3)
			{
				return this["_ActionPoint"+_nowCount];
			}
			if (i==1)
			{
				if (_nowCount==3)
				{
					return _ActionPoint1;
				}
				if (_nowCount==2)
				{
					return _ActionPoint3;
				}
				if (_nowCount==1)
				{
					return _ActionPoint2;
				}
			}
			if (i==2)
			{
				if (_nowCount==3)
				{
					return _ActionPoint2;
				}
				if (_nowCount==2)
				{
					return _ActionPoint1;
				}
				if (_nowCount==1)
				{
					return _ActionPoint3;
				}
			}
			return new ActionPoint (0);
		}

	}
}