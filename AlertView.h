//
//  AlertView.h
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertView : NSObject
{
    NSString *_text;
    NSString *_title;
    NSString *_cancelButtonTitle;
    NSString *_otherButtonTitle;
}

- (NSString *)text;

- (void)setText:(NSString *)text;
- (void)setTitle:(NSString *)title;
- (void)setCancelButtonTitle:(NSString *)title;
- (void)setOtherButtonTitle:(NSString *)title;
- (UIAlertController *)build;

@end
