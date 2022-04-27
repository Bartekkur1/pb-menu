import Toybox.Lang;
import Toybox.WatchUi;

class pbMenuErrorDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }   

    function onBack() {
        return true;
    }
}

class pbMenuError extends WatchUi.View {

    var errorMessage;

    function initialize() {
        View.initialize();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        errorMessage = new WatchUi.Text({
            :text=>"Wystąpił błąd! :(",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SMALL,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER
        });
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        errorMessage.draw(dc);
    }
}