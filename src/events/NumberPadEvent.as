package events
{
	import flash.events.Event;
	
	public class NumberPadEvent extends Event
	{
		public static const EVENT_UPDATE:String = "numberPadUpdate";
		public static const EVENT_KEYDOWN:String = "numberPadKeyDown";

		public var stringValue:String;
		
		public function NumberPadEvent(type:String, stringValue:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event {
			return new NumberPadEvent(type, stringValue, bubbles, cancelable );
		}
	}
}