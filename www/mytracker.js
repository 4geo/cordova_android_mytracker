var exec = require('cordova/exec');

exports.init = function (arg0, success, error) {
    exec(success, error, 'MyTrackerPlugin', 'initTracker', [arg0]);
};
exports.setCustomUserId = function (userId, success, error) {
    exec(success, error, 'MyTrackerPlugin', 'setCustomUserId', [userId]);
};
exports.trackEvent = function (eventName, eventParams, success, error) {
    exec(success, error, 'MyTrackerPlugin', 'trackEvent', [eventName, eventParams]);
};
exports.setDebugMode = function (debugMode, success, error) {
    exec(success, error, 'MyTrackerPlugin', 'setDebugMode', [debugMode]);
};
