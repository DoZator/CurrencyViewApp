//
//  CurrencyRequest.h
//  CurrencyViewApp
//
//  Created by Oleg Bogatenko on 4/9/15.
//  Copyright (c) 2015 Oleg Bogatenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrencyRequest : NSObject <NSURLConnectionDelegate>
{
    void (^_requestCompletion)(BOOL status, NSString *reason, NSData *response);
}

- (instancetype)initWithURLString:(NSString *)urlString;

- (void)GET:(void (^)(BOOL status, NSString *reason, NSData *response))completion;

@end
