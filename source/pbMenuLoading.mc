import Toybox.Lang;
import Toybox.WatchUi;

class MyProgressDelegate extends WatchUi.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }   

    function onBack() {
        return true;
    }
}

class pbMenuLoading extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) as Void {
        var progressBar = new WatchUi.ProgressBar("Pobieranie \n jadłospisu...", null);
        WatchUi.pushView(progressBar, new MyProgressDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }
}