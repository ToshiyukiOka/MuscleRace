//
//  KiiCreateObjectViewController.m
//  KiiTutorialApp
//
//  Created by Ryuji OCHI on 11/15/13.
//  Copyright (c) 2013 Kii Corporation. All rights reserved.
//

#import <KiiSDK/KiiBucket.h>
#import <KiiSDK/Kii.h>
#import "KiiCreateObjectViewController.h"
#import "KiiFileUploadViewController.h"
#import "KiiViewUtilities.h"
#import "KiiAppConstants.h"
#import "KiiCommonUtilities.h"
#import "AlertView.h"
#import "SVProgressHUD.h"
#import "ApiClient.h"
#import "AppUser.h"

@interface KiiCreateObjectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *descView;
@end

@implementation KiiCreateObjectViewController

@synthesize groupNameField;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)mCreateKiiObjectButton:(id)sender {
    
    //[self.view endEditing:YES];
    
    NSString *enteredText = self.groupNameField.text;
    
    AlertView *alertView = [AlertView new];
    ApiClient *api = [[ ApiClient alloc] initWithPath:@"/groups"];
    AppUser *appUser = [[AppUser alloc] init];
    
    if ([enteredText length] == 0) {
        [alertView setText:@"グループ名が入力されていません"];
        [self presentViewController:[alertView build] animated:YES completion:nil];
        return;
    }

    // for signup
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"Creating..." maskType:SVProgressHUDMaskTypeGradient];
    
    NSDictionary *parameters =
        @{ @"group": @{ @"name": enteredText }};
    
    [api.manager POST:api.getUrl parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [SVProgressHUD dismiss];
                  
                  // login or signUp succe
                  if([(NSNumber *)responseObject[@"result"] boolValue] == TRUE){
                      [SVProgressHUD showSuccessWithStatus:@"Success！"];
                      
                      [self.navigationController popViewControllerAnimated:YES];
                  }else if([(NSNumber *)responseObject[@"result"] boolValue] == FALSE){ // failed
                      [SVProgressHUD dismiss];
                      [alertView setText:@"create error!"];
                      [self presentViewController:[alertView build] animated:YES completion:nil];
                      return;
                  }
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [SVProgressHUD dismiss];
                  [alertView setTitle:@"Server Error"];
                  [alertView setText:@"通信でエラーが発生しました。再度試して下さい。"];
                  [self presentViewController:[alertView build] animated:YES completion:nil];
              }
     ];
    
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"CreateObjectCompleted"]) {
//        KiiFileUploadViewController *viewController = (KiiFileUploadViewController *) [segue destinationViewController];
//        viewController.kiiObject = self.kiiObject;
//    }
//}

- (void)descViewTaped:(UIGestureRecognizer *)gestureRecognizer {
    
    [self performSegueWithIdentifier:@"KiiObjectCreateDesc" sender:gestureRecognizer];
}

@end
