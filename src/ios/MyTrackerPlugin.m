#import "MyTrackerPlugin.h"
#import <Cordova/CDVViewController.h>
#import <MyTrackerSDK/MyTrackerSDK.h>

@implementation MyTrackerPlugin

#pragma mark - General

- (void) initTracker:(CDVInvokedUrlCommand *)command
{
    NSString *SDK_KEY = [command argumentAtIndex:0];
    
    [MRMyTracker setupTracker:SDK_KEY];
    
    // Send callback successfull
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) setCustomUserId:(CDVInvokedUrlCommand *)command
{
    NSString *userID = [command argumentAtIndex:0];

    MRMyTrackerParams *trackerParams = [MRMyTracker trackerParams];

    trackerParams.customUserId = userID;
    
    // Send callback successfull
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) trackEvent:(CDVInvokedUrlCommand *)command
{
    NSString *eventName = [command argumentAtIndex:0];
    NSDictionary* params = [command argumentAtIndex:1];
    NSMutableDictionary<NSString *, NSString *> *eventCustomParams = [[NSMutableDictionary alloc]init];
    
    for (NSString* key in params) {
        NSString* value = (NSString *) params[key];
        [eventCustomParams addEntriesFromDictionary:@{[NSString stringWithFormat:@"%@", key]:[NSString stringWithFormat:@"%@", value]}];
    }
    
    [MRMyTracker trackEventWithName:eventName eventParams:eventCustomParams];
    
    // Send callback successfull
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

#pragma mark - Configuration

- (void) setTrackingLaunchEnabled:(CDVInvokedUrlCommand *)command
{
    BOOL isEnabled = [[command argumentAtIndex:0] boolValue];
    
    MRMyTrackerConfig *trackerConfig = [MRMyTracker trackerConfig];
    trackerConfig.trackLaunch = isEnabled;
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) setLaunchTimeout:(CDVInvokedUrlCommand *)command
{
    NSNumber *seconds = [command argumentAtIndex:0];
    NSTimeInterval timeInterval = [seconds doubleValue];
    
    MRMyTrackerConfig *trackerConfig = [MRMyTracker trackerConfig];
    trackerConfig.launchTimeout = timeInterval;
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) setBufferingPeriod:(CDVInvokedUrlCommand *)command
{
    NSNumber *seconds = [command argumentAtIndex:0];
    NSTimeInterval timeInterval = [seconds doubleValue];
    
    MRMyTrackerConfig *trackerConfig = [MRMyTracker trackerConfig];
    trackerConfig.bufferingPeriod = timeInterval;
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) setForcingPeriod:(CDVInvokedUrlCommand *)command
{
    NSNumber *seconds = [command argumentAtIndex:0];
    NSTimeInterval timeInterval = [seconds doubleValue];
    
    MRMyTrackerConfig *trackerConfig = [MRMyTracker trackerConfig];
    trackerConfig.forcingPeriod = timeInterval;
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) setAutotrackingPurchaseEnabled:(CDVInvokedUrlCommand *)command
{
    BOOL isEnabled = [[command argumentAtIndex:0] boolValue];
    
    MRMyTrackerConfig *trackerConfig = [MRMyTracker trackerConfig];
    trackerConfig.autotrackPurchase = isEnabled;
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

#pragma mark - Android

- (void) setTrackingLocationEnabled:(CDVInvokedUrlCommand *)command
{
    BOOL isEnabled = [[command argumentAtIndex:0] boolValue];
    
    // Do nothing! (Android only)

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) setTrackingPreinstallEnabled:(CDVInvokedUrlCommand *)command
{
    BOOL isEnabled = [[command argumentAtIndex:0] boolValue];
    
    // Do nothing! (Android only)

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

#pragma mark - iOS

- (void) setLocationTrackingMode:(CDVInvokedUrlCommand *)command
{
    NSNumber *packet = [command argumentAtIndex:0];
    int index = [packet intValue];
    MRLocationTrackingMode mode = MRLocationTrackingModeNone;

    switch (index)
    {
        case 0: // None
            // mode = MRLocationTrackingModeNone;
            break;
        case 1: // Cached
            mode = MRLocationTrackingModeCached;
            break;
        case 2: // Active
            mode = MRLocationTrackingModeActive;
            break;
        // default: // None
            // mode = MRLocationTrackingModeNone;
    }
    
    MRMyTrackerConfig *trackerConfig = [MRMyTracker trackerConfig];
    trackerConfig.locationTrackingMode = mode;
    
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

#pragma mark - Tools

- (void) setDebugMode:(CDVInvokedUrlCommand *)command
{
    BOOL isEnabled = [[command argumentAtIndex:0] boolValue];

    [MRMyTracker setDebugMode:isEnabled];

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:command.arguments];
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end