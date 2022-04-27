import Toybox.Lang;
import Toybox.WatchUi;

class pbMenuFoodDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    function onSelect(item) {}
}

class pbMenuListDelegate extends WatchUi.Menu2InputDelegate {

    var foodCatalog;

    function getMeals(pickedType) as Array { 
        var menuData = self.foodCatalog.get("menu") as Array;
        for (var i = 0; i < menuData.size(); i++) {
            var typeCatalog = menuData[i] as Dictionary;
            var type = typeCatalog.get("type");
            if(type == pickedType) {
                return typeCatalog.get("meals");
            }
        }
        return [];
    }

    function buildMenu(pickedType) {
        var meals = self.getMeals(pickedType);

        var title = new WatchUi.Text({
            :text=>pickedType,
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER
        });
        var menu = new WatchUi.Menu2({:title=>title});
        for (var i = 0; i < meals.size(); i++) {
            var meal = meals[i];
            var name = meal.get("name");
            var mealSubtitle = meal.get("title");
            menu.addItem(new WatchUi.MenuItem(name, mealSubtitle, name, {}));
        }
        return menu;
    }

    function onSelect(item) {
        var menu = self.buildMenu(item.getId());
        WatchUi.pushView(menu, new pbMenuFoodDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }

    function initialize(foodCatalog) {
        Menu2InputDelegate.initialize();
        self.foodCatalog = foodCatalog;
    }

    function onBack() {
        WatchUi.pushView(new pbMenuView(), new pbMenuDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}

class pbMenuDelegate extends WatchUi.BehaviorDelegate {

    var foodCatalog;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function buildMenuItem(title, id) as WatchUi.MenuItem {
        return new WatchUi.MenuItem(title, null, id, {});
    }

    function handleResponse(responseCode as Number, data as Dictionary?) as Void {
        if (responseCode == 200) {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            self.foodCatalog = data;
            WatchUi.pushView(self.buildMenu(), new pbMenuListDelegate(data), WatchUi.SLIDE_IMMEDIATE);
        } else {
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            WatchUi.pushView(new pbMenuError(), new pbMenuErrorDelegate(), WatchUi.SLIDE_IMMEDIATE);
        }
    }

    function extractTypes(data) {
        var types = [];
        var menuData = data.get("menu") as Array;
        for (var i = 0; i < menuData.size(); i++) {
            var typeCatalog = menuData[i] as Dictionary;
            types.add(typeCatalog.get("type"));
        }
        return types;
    }

    function buildMenu() {
        var types = self.extractTypes(self.foodCatalog);

        var title = new WatchUi.Text({
            :text=>"Rodzaje",
            :locX =>WatchUi.LAYOUT_HALIGN_CENTER
        });
        var menu = new WatchUi.Menu2({:title=>title});
        for (var i = 0; i < types.size(); i++) {
            var type = types[i];
            menu.addItem(self.buildMenuItem(type, type));
        }
        return menu;
    }

    function onSelect() {
        ApiConnector.makeRequest(method(:handleResponse));
        WatchUi.pushView(new pbMenuLoading(), new MyProgressDelegate(), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}