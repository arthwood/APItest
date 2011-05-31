package view {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import com.arthwood.components.ContentSimpleVScroll;
	import com.arthwood.components.Scroll;
	import com.arthwood.components.TextScroll;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Response extends MovieClip	{
		public var tfText:TextField;
		public var scroll:Scroll;
		public var textScroll:TextScroll;
		
		public function Response() {
			textScroll = new TextScroll(tfText, scroll);
		}
	}
}