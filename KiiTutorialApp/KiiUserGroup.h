//
//  KiiUserGroup.h
//  KiiTutorialApp
//
//  Created by Toshiyuki Oka on 11/15/14.
//  Copyright (c) 2014 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <KiiSDK/KiiObject.h>

@interface KiiUserGroup : NSObject

@property NSString *groupName;
@property BOOL completed;
@property (readonly) NSDate *creationDate;

@end
