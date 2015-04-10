//
//  ViewController.m
//  CurrencyViewApp
//
//  Created by Oleg Bogatenko on 4/9/15.
//  Copyright (c) 2015 Oleg Bogatenko. All rights reserved.
//

#import "ViewController.h"
#import "CurrencyTransporter.h"

typedef NS_ENUM(NSInteger, CurrencyType) {
    CurrencyTypeRU,
    CurrencyTypeUS
};

@interface ViewController ()
{
    CurrencyType currentType;
}

- (IBAction)getCurrency:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction)getCurrency:(UIButton *)sender
{
    currentType = sender.tag;
    
    [self sendRequestThenNotify];
}

- (void)sendRequestThenNotify
{
    CurrencyTransporter *ct = [CurrencyTransporter new];
    
    [ct takeCurrencies:^(BOOL success, NSDictionary *data){
        
        if (success)
        {
            NSMutableDictionary *currency = [NSMutableDictionary new];
            
            if (currentType == CurrencyTypeRU)
                [currency setObject:[data objectForKey:@"RUB"] forKey:@"RUB"];
            else
                [currency setObject:[data objectForKey:@"USD"] forKey:@"RUB"];
            
            [self sendNotificationWithData:currency];
        }
    }];
}

- (void)sendNotificationWithData:(NSDictionary *)dict
{    
    UILocalNotification *localNotification = [UILocalNotification new];
    
    localNotification.alertBody = [dict allKeys][0];
    localNotification.alertTitle = @"Currency";
    localNotification.userInfo = @{ @"rate" : dict[[dict allKeys][0]] };
    localNotification.timeZone = [NSTimeZone localTimeZone];
    localNotification.category = @"watch";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

@end
