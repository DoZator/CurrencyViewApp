//
//  NotificationController.m
//  Currency WatchKit Extension
//
//  Created by Oleg Bogatenko on 4/10/15.
//  Copyright (c) 2015 Oleg Bogatenko. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *currencyLabel;

@end


@implementation NotificationController

@synthesize currencyLabel;

- (void)willActivate
{
    [super willActivate];
}

- (void)didDeactivate
{
    [super didDeactivate];
}

- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification
                      withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler
{
    NSString *currencyName = remoteNotification[@"aps"][@"alert"][@"body"];
    NSString *currencyRate = remoteNotification[@"rate"];
    
    [currencyLabel setText:[NSString stringWithFormat:@"%@ : %@", currencyName, currencyRate]];
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}

@end



