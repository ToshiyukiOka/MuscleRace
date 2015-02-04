//
//  MuscleFinishViewController.m
//  MuscleRace
//
//  Created by Yuki Moriyama on 2015/02/04.
//  Copyright (c) 2015年 Kii Corporation. All rights reserved.
//

#import "MuscleFinishViewController.h"
#import "AlertView.h"
#import "SVProgressHUD.h"
#import "ApiClient.h"
#import "AppUser.h"

@interface MuscleFinishViewController ()

@end

@implementation MuscleFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ApiClient *api = [[ ApiClient alloc] initWithPath:@"/training_logs"];
    AppUser *appUser = [[ AppUser alloc] init];
    AlertView *alertView = [AlertView new];
    
    _finishCountLabel.text = self.finishCount;
    
    NSDictionary *parameters = @{ @"training_log": @{@"user_id": @3, @"group_id": @3, @"counts": @40 } };
    [api.manager POST:api.getUrl parameters:parameters
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 //特に何もしない
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [SVProgressHUD dismiss];
                 [alertView setTitle:@"Server Error"];
                 [alertView setText:@"通信でエラーが発生しました。再度試して下さい。"];
                 [self presentViewController:[alertView build] animated:YES completion:nil];
             }
     ];
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
