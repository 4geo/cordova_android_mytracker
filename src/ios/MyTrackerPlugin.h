#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface MyTrackerPlugin : CDVPlugin

// ------ General

- (void)initTracker:(CDVInvokedUrlCommand *)command;
- (void)setCustomUserId:(CDVInvokedUrlCommand *)command;
- (void)trackEvent:(CDVInvokedUrlCommand *)command;

// ------ Configuration

- (void)setTrackingLaunchEnabled:(CDVInvokedUrlCommand *)command;
- (void)setLaunchTimeout:(CDVInvokedUrlCommand *)command;
- (void)setBufferingPeriod:(CDVInvokedUrlCommand *)command;
- (void)setForcingPeriod:(CDVInvokedUrlCommand *)command;
- (void)setAutotrackingPurchaseEnabled:(CDVInvokedUrlCommand *)command;
- (void)setRegion:(CDVInvokedUrlCommand *)command;

// ------ Android

- (void)setTrackingLocationEnabled:(CDVInvokedUrlCommand *)command;
- (void)setTrackingPreinstallEnabled:(CDVInvokedUrlCommand *)command;

// ------ iOS

- (void)setLocationTrackingMode:(CDVInvokedUrlCommand *)command;

// ------ Tools

- (void)setDebugMode:(CDVInvokedUrlCommand *)command;

@end