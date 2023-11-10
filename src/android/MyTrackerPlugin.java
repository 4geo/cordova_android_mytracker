package MyTracker;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.my.tracker.MyTracker;
/**
 * This class echoes a string called from JavaScript.
 */
public class MyTrackerPlugin extends CordovaPlugin {

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("init")) {
            String message = args.getString(0);
            this.init(message, callbackContext);
            return true;
        }
        return false;
    }

    private void init(String SDK_KEY, CallbackContext callbackContext) {

        try {
            if (SDK_KEY != null && SDK_KEY.length() > 0) {
                MyTracker.initTracker(SDK_KEY, cordova.getActivity().getApplication());
                MyTracker.trackLaunchManually(cordova.getActivity());
                callbackContext.success();
            } else {
                callbackContext.error("Expected one non-empty string argument.");
            }
        }
        catch (Exception e){
            callbackContext.error("Exception"+ e.getMessage());
        }
    }
}
