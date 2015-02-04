//
//  AppUser.h
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUser : NSObject

@property (nonatomic)NSString *name;
@property (nonatomic)NSUserDefaults *ud;
@property (nonatomic)NSString *userId;

- (void)setUp;
- (void)setName:(NSString *)name;
- (void)setUserId:(NSString *)userId;
- (id)init;

@end
