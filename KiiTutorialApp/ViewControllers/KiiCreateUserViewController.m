//
//  KiiCreateUserViewController.m
//  KiiTutorialApp
//
//  Created by Ryuji OCHI on 11/15/13.
//  Copyright (c) 2013 Kii Corporation. All rights reserved.
//

#import "KiiCreateUserViewController.h"
#import "KiiUserDescViewController.h"
#import "KiiViewUtilities.h"
#import "KiiCommonUtilities.h"
#import <KiiSDK/KiiUser.h>
#import <KiiSDK/KiiBucket.h>
#import <KiiSDK/Kii.h>
#import "KiiCreateObjectViewController.h"
#import "KiiFileUploadViewController.h"
#import "KiiAppConstants.h"
#import "AlertView.h"
#import "SVProgressHUD.h"
#import "ApiClient.h"
#import "AppUser.h"

@interface KiiCreateUserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *descView;

@end

@implementation KiiCreateUserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(descViewTaped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.descView addGestureRecognizer:singleTap];
    [self.descView setUserInteractionEnabled:YES];
}

- (IBAction)mSignUpButton:(id)sender {
    // Hide keyboard
    [self.view endEditing:YES];
    [self login:@"signUp"];
}

- (IBAction)mSignInButton:(id)sender {
    // Hide keyboard
    [self.view endEditing:YES];
    [self login:@"signIn"];
}

- (void)login:(NSString *)methodType {

    // Get username and password from text field
    NSString *userName = [self.usernameField text];
    NSString *password = [self.passwordField text];
    
    AlertView *alertView = [AlertView new];
    ApiClient *api = [[ ApiClient alloc] initWithPath:@"/login"];
    
    if ([methodType isEqualToString:@"signIn"]) {
        [alertView setTitle:@"Sign In Error"];
    } else if ([methodType isEqualToString:@"signUp"]) {
        [alertView setTitle:@"Sign Up Error"];
         api.path = @"/users";
    }
    
    // validation error
    if([userName length] == 0){
        [alertView setText:@"ユーザ名が入力されていません"];
        [self presentViewController:[alertView build] animated:YES completion:nil];
        return;
    }else if([password length] == 0){
        [alertView setText:@"メールアドレスが入力されていません"];
        [self presentViewController:[alertView build] animated:YES completion:nil];
        return;
    }
    
    // for signup
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
    
    NSDictionary *parameters = @{ @"user": @{@"name": userName, @"password": password } };
    [api.manager POST:api.getUrl parameters:parameters
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [SVProgressHUD dismiss];
                  
                  // login or signUp succe
                  if([(NSNumber *)responseObject[@"result"] boolValue] == TRUE){
                      [SVProgressHUD showSuccessWithStatus:@"Success！"];
                      // stock user data to NsUserDefault
                      AppUser *appUser = [[AppUser alloc] init];
                      [appUser setName: userName];
                      [appUser setUserId: responseObject[@"user_id"]];
                      [self performSegueWithIdentifier:@"LoginCompleted" sender:self];
                  }else if([(NSNumber *)responseObject[@"result"] boolValue] == FALSE){ // failed
                      [SVProgressHUD dismiss];
                      [alertView setText:@"user_name or password is wrong!"];
                      [self presentViewController:[alertView build] animated:YES completion:nil];
                      return;
                  }
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [SVProgressHUD dismiss];
                  [alertView setTitle:@"Server Error"];
                  [alertView setText:@"通信でエラーが発生しました。再度試して下さい。"];
                  [self presentViewController:[alertView build] animated:YES completion:nil];
              }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)descriptionFieldGestureHandler:(id)sender {
    [self.view endEditing:YES];
}

- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

- (void)descViewTaped:(UIGestureRecognizer *)gestureRecognizer {
    
    [self performSegueWithIdentifier:@"UserDesc" sender:gestureRecognizer];
}
@end
