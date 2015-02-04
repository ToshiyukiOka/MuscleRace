//
//  MuscleGroup.h
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MuscleGroup : NSObject

@property NSString *name;
@property NSInteger *groupId;

- (id)initWithName:(NSString *)name groupId:(NSInteger)groupId;


@end
