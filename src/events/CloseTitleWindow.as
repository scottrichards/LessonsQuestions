package events
{
	import flash.events.Event;
	
	public class CloseTitleWindow extends Event
	{
		public static const EVENT_NAME:String = "closeTitleWindow";
		
		public function CloseTitleWindow(type:String = EVENT_NAME, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(EVENT_NAME, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new CloseTitleWindow(EVENT_NAME, bubbles, cancelable );
		}
	}
}