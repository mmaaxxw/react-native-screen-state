#import "RNScreenState.h"

#import <React/RCTBridge.h>
#import <React/RCTConvert.h>
#import <React/RCTEventDispatcher.h>
#import <React/RCTUtils.h>
#import "notify.h"

@implementation RNScreenState

RNScreenState *globalSelf;
bool isLocked = false;
bool isRegistered = false;


RCT_EXPORT_MODULE();

- (NSArray<NSString *> *)supportedEvents
{
    return @[@"screenStateDidChange"];
}

RCT_EXPORT_METHOD(register){
    if(!isRegistered){
        globalSelf = self;
        
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), //center
                                        NULL, // observer
                                        displayStatusChanged, // callback
                                        CFSTR("com.apple.springboard.lockstate"), // event name
                                        NULL, // object
                                        CFNotificationSuspensionBehaviorDeliverImmediately);
        isRegistered = true;
        NSLog(@"Darwin notification registeForDeviceLockNotification");
    }
}

RCT_EXPORT_METHOD(unregister){
    CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                       NULL,
                                       CFSTR("com.apple.springboard.lockstate"),
                                       NULL);
    isRegistered = false;
    NSLog(@"Darwin notification unregisteForDeviceLockNotification");
}

-(void)tooggleIsLocked{
    isLocked = !isLocked;
}

void displayStatusChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    //     the "com.apple.springboard.lockcomplete" notification will always come after the "com.apple.springboard.lockstate" notification
    //
    //      NSString *lockState = (NSString*)name;
    
    [globalSelf tooggleIsLocked];
    [globalSelf sendEventWithName:@"screenStateDidChange" body:@{@"isScreenOn": !isLocked ? @"true" : @"false"}];
    NSLog(@"Darwin notification NAME = %@",name);
    NSLog(@"Darwin notification isLocked =  %@", isLocked ? @"TRUE" : @"FALSE");
//    NSLog(isLocked ? @"Darwin notification Yes" : @"Darwin notification No");
}

@end