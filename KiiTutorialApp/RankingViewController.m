//
//  RankingViewController.m
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import "RankingViewController.h"

@interface RankingViewController ()

@end

@implementation RankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Ranking" image:[UIImage imageNamed:@"title.png"] tag:0];
    self.tabBarItem = item;
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
