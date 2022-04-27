import Toybox.System;
import Toybox.Communications;
import Toybox.Lang;
import Toybox.Application.Properties;

class ApiConnector {

    function makeRequest(responseHandler) {
        var url = Properties.getValue("url");

        var request = Communications.makeWebRequest(url, null, {
            :method => Communications.HTTP_REQUEST_METHOD_GET
        }, responseHandler);
    }

}