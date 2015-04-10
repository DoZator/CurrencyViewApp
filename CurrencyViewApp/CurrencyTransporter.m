//
//  CurrencyTransporter.m
//  CurrencyViewApp
//
//  Created by Oleg Bogatenko on 4/9/15.
//  Copyright (c) 2015 Oleg Bogatenko. All rights reserved.
//

#import "CurrencyTransporter.h"
#import "CurrencyRequest.h"

@interface CurrencyTransporter () <NSXMLParserDelegate>
{
    NSString *element;
    NSMutableDictionary *currensies;
}

- (void)sendCurrencyRequest;

@end

@implementation CurrencyTransporter

const NSString *SERVER_URL = @"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml";

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        currensies = [NSMutableDictionary new];
    }
    return self;
}

- (void)takeCurrencies:(void (^)(BOOL, NSDictionary *))handler
{
    _getCompletion = [handler copy];
    
    [self sendCurrencyRequest];
}

- (void)sendCurrencyRequest
{
    CurrencyRequest *req = [[CurrencyRequest alloc] initWithURLString:(NSString *)SERVER_URL];
    
    [req GET:^(BOOL success, NSString *message, NSData *data){
        
        if (success)
        {
            NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
            parser.delegate = self;
            [parser parse];
        }
        else
        {
            NSLog(@"%@", message);
            
            _getCompletion(NO, nil);
        }
    }];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    element = elementName;
    
    if (attributeDict.allKeys.count > 1 && [element isEqualToString:@"Cube"])
    {
        [currensies setObject:[attributeDict objectForKey:@"rate"]
                       forKey:[attributeDict objectForKey:@"currency"]];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    _getCompletion(YES, currensies);
}

@end
