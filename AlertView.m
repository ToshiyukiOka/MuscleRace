//
//  AlertView.m
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

- (void)setText:(NSString *)text
{
    _text = text;
}

- (void)setTitle:(NSString *)title{
    _title = title;
}

- (void)setCancelButtonTitle:(NSString *)title
{
    _cancelButtonTitle = title;
}

- (void)setOtherButtonTitle:(NSString *)title{
    _otherButtonTitle = title;
}

- (NSString *)text{
    return _text;
}

- (UIAlertController *)build
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:_title message:_text preferredStyle:UIAlertControllerStyleAlert];
    
    // addActionした順に左から右にボタンが配置されます
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK"
style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // otherボタンが押された時の処理
    }]];
    return alertController;
}

@end
