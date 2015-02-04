//
//  MuscleGroup.m
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import "MuscleGroup.h"

@implementation MuscleGroup

- (id)initWithName:(NSString *)name groupId:(NSInteger)groupId {
    self = [super init];
    _name = name;
    _groupId = &groupId;
    return self;
}

@end
