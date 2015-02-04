//
//  MuscleNavigationController.m
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import "MuscleNavigationController.h"

@interface MuscleNavigationController ()

@end

@implementation MuscleNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Muscle" image:[UIImage imageNamed:@"training"] tag:0];
    self.tabBarItem = item;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
