//
//  ApiClient.m
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import "ApiClient.h"

@implementation ApiClient

- (id)initWithPath:(NSString *)path {
    self = [super init];
    self.hostUrl = @"http://157.7.161.65:1121";
    self.apiKey = @"aaaaaaaaaa";
    self.path = path;
    self.manager = [AFHTTPRequestOperationManager manager];
    return self;
}

- (NSString *)getUrl {
    NSString *url = [self.hostUrl stringByAppendingString:self.path];
    return [url stringByAppendingString:@".json"];
}

@end
