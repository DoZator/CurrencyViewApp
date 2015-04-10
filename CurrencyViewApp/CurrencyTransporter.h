//
//  CurrencyTransporter.h
//  CurrencyViewApp
//
//  Created by Oleg Bogatenko on 4/9/15.
//  Copyright (c) 2015 Oleg Bogatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrencyTransporter : NSObject
{
    void (^_getCompletion)(BOOL status, NSDictionary *data);
}

- (void)takeCurrencies:(void(^)(BOOL status, NSDictionary *data))handler;

@end
