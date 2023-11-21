package MyTracker;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.my.tracker.MyTracker;
import com.my.tracker.MyTrackerParams;
import java.util.*;

/**
 * This class echoes a string called from JavaScript.
 */
public class MyTrackerPlugin extends CordovaPlugin {

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        switch (action) {
            case "initTracker":
                this.initTracker(data, callbackContext);
                break;
            case "trackEvent":
                this.trackEvent(data, callbackContext);
                break;
            case "setCustomUserId":
                this.setCustomUserId(data, callbackContext);
                break;
            case "setDebugMode":
                this.setDebugMode(data, callbackContext);
            default:
                return false;
        }
        return true;
    }

    private void initTracker(JSONArray data, CallbackContext callbackContext) {
        try {
            String SDK_KEY = data.getString(0);
            if (SDK_KEY != null && SDK_KEY.length() > 0) {
                MyTracker.initTracker(SDK_KEY, cordova.getActivity().getApplication());
                MyTracker.trackLaunchManually(cordova.getActivity());
                callbackContext.success();
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }
        } catch (Exception e) {
            callbackContext.error("Exception "+ e.getMessage());
        }
    }

    private void trackEvent(JSONArray data, CallbackContext callbackContext) {
        try {
            String eventName = data.getString(0);
            Map<String, String> eventParams = this.toMap(data.getJSONObject(1));

            if (eventName != null && eventName.length() > 0) {
                MyTracker.trackEvent(eventName, eventParams);
                callbackContext.success();
            } else {
                callbackContext.error("eventName non-empty string.");
            }
        } catch (Exception e) {
            callbackContext.error("Exception "+ e.getMessage());
        }
    }

    private void setCustomUserId(JSONArray data, CallbackContext callbackContext) {
        try {
            String userId = data.getString(0);
            if (userId != null && userId.length() > 0) {
                MyTrackerParams trackerParams = MyTracker.getTrackerParams();
                trackerParams.setCustomUserId(userId);
                callbackContext.success();    
            } else {
                callbackContext.error("userId non-empty");
            }
        } catch (Exception e) {
            callbackContext.error("Exception "+ e.getMessage());
        }
    }

    private void setDebugMode(JSONArray data, CallbackContext callbackContext) {
        try {
            Boolean debugMode = data.getBoolean(0);
            MyTracker.setDebugMode(debugMode);
            callbackContext.success();
        } catch (Exception e) {
            callbackContext.error("Exception "+ e.getMessage());
        }
    }

    private static Map<String, String> toMap(JSONObject jsonobj) throws JSONException {
        Map<String, String> map = new HashMap<String, String>();
        Iterator<String> keys = jsonobj.keys();
        while(keys.hasNext()) {
            String key = keys.next();
            String value = jsonobj.getString(key);
            map.put(key, value);
        }
        return map;
    }

}
