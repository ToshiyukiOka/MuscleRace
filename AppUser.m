//
//  AppUser.m
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import "AppUser.h"

@implementation AppUser


- (id)init {
    [self setUp];
    return self;
}

- (void)setUp {
    self.ud = [NSUserDefaults standardUserDefaults];
    self.name = [self.ud objectForKey:@"name"];
    self.userId = [self.ud objectForKey:@"userId"];
}

- (void)setName:(NSString *)name{
    [self.ud setObject:name forKey:@"name"];
    
}

- (void)setUserId:(NSString *)userID {
    [self.ud setObject:userID forKey:@"userId"];
    
}
    

@end
