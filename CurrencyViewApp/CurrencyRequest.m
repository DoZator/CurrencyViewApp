//
//  CurrencyRequest.m
//  CurrencyViewApp
//
//  Created by Oleg Bogatenko on 4/9/15.
//  Copyright (c) 2015 Oleg Bogatenko. All rights reserved.
//

#import "CurrencyRequest.h"

@interface CurrencyRequest ()
{
    NSURL *url;
    
    NSMutableURLRequest *request;
    NSMutableData *responseData;
}

- (void)startRequest;

@end

@implementation CurrencyRequest

- (instancetype)initWithURLString:(NSString *)urlString
{
    self = [super init];
    
    if (self)
    {
        url = [NSURL URLWithString:urlString];
    }
    return self;
}

- (void)GET:(void (^)(BOOL, NSString *, NSData *))completion
{
    _requestCompletion = [completion copy];
    
    [self startRequest];
}

- (void)startRequest
{
    request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    [connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    if (!connection)
    {
        _requestCompletion(NO, @"Connection error!", nil);
    }
    else
        [connection start];
}

#pragma mark - NSURLConnection Delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    responseData = [NSMutableData new];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _requestCompletion(NO, error.localizedDescription, nil);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _requestCompletion(YES, nil, responseData);
}

@end
