package view {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import pl.arthwood.components.ContentSimpleVScroll;
	import pl.arthwood.components.SimpleVScroll;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Response extends MovieClip	{
		public var tfText:TextField;
		public var simpleVScroll:SimpleVScroll;
		public var contentSimpleVScroll:ContentSimpleVScroll;
		
		public function Response() {
			tfText.autoSize = TextFieldAutoSize.LEFT;
			contentSimpleVScroll = new ContentSimpleVScroll(simpleVScroll, tfText, new Point(360, 240));
		}
	}
}