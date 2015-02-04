//
//  ApiClient.h
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"

@interface ApiClient : NSObject

@property NSString *hostUrl;
@property NSString *apiKey;
@property AFHTTPRequestOperationManager *manager;
@property NSString *path;

- (id)initWithPath:(NSString *)path;
- (NSString *)getUrl;


@end