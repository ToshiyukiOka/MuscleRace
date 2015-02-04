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

    // ラベルをビューの中心に貼り付ける
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 30.0)];
    label.text = @"Count";
    label.textAlignment = NSTextAlignmentCenter;
    label.center = self.view.center;
    [self.view addSubview:label];
    
    // ラベルをフェードイン、フェードアウトさせるアニメーションを開始する
    CABasicAnimation* Counter_Opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    Counter_Opacity.fromValue = [NSNumber numberWithFloat:1];
    Counter_Opacity.toValue = [NSNumber numberWithFloat:0];
    
    CABasicAnimation* Counter_Scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    Counter_Scale.fromValue = @1.0;
    Counter_Scale.toValue = @3.0;
    Counter_Scale.fillMode = kCAFillModeBoth;
    Counter_Scale.delegate = self;

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.5;

    group.animations = [NSArray arrayWithObjects:Counter_Opacity, Counter_Scale, nil];
    [label.layer addAnimation:group forKey:@"MyAnimation"];
    
}

- (IBAction)mSignUpButton:(id)sender {
    // Hide keyboard
    [self.view endEditing:YES];

    // Get username and password from text field
    NSString *userIdentifier = [self.usernameField text];
    NSString *password = [self.passwordField text];
    
    // validation error
    AlertView *alertView = [AlertView new];
    [alertView setTitle:@"Sign Up Error"];
    
    if([userIdentifier length] == 0){
        [alertView setText:@"ユーザ名が入力されていません"];
        [self presentViewController:[alertView build] animated:YES completion:nil];
        return;
    }else if([password length] == 0){
        [alertView setText:@"メールアドレスが入力されていません"];
        [self presentViewController:[alertView build] animated:YES completion:nil];
        return;
    }
    
    // Create KiiUser from username and password
    KiiUser *user = [KiiUser userWithUsername:userIdentifier andPassword:password];
    // Do register with Blocks
    [user performRegistrationWithBlock:^(KiiUser *retUser, NSError *retError) {
        [KiiViewUtilities hideProgressHUD:self.view];

        // Check returning error
        if (retError) {
            NSString *errorMessage = @"Registration failed.";
            NSString *detailedMessage = [KiiCommonUtilities errorDetailsMessage:retError];
            [KiiViewUtilities showFailureHUD:errorMessage withDetailsText:detailedMessage andView:self.view];
        } else {
            [self performSegueWithIdentifier:@"LoginCompleted" sender:self];
            KiiBucket *bucket = [[KiiUser currentUser] bucketWithName:@"count"];
            // Create an object with key/value pairs
            KiiObject *object = [bucket createObject];
            [object setObject:[NSNumber numberWithInt:0]
                       forKey:@"count"];
            [object setObject:@"active"
                       forKey:@"status"];
            
            // Save the object
            NSError *error;
            [object saveSynchronous:&error];
            if (error != nil) {
                // Saving object failed
                // Please check error description/code to see what went wrong...
            }
        }
    }];

    [KiiViewUtilities showProgressHUD:@"Processing..." withView:self.view];
}

- (IBAction)mSignInButton:(id)sender {
    // Hide keyboard
    [self.view endEditing:YES];

    // Get username and password from text field
    NSString *userIdentifier = [self.usernameField text];
    NSString *password = [self.passwordField text];

    // Do authenticate with Blocks
    [KiiUser authenticate:userIdentifier withPassword:password andBlock:^(KiiUser *retUser, NSError *retError) {
        [KiiViewUtilities hideProgressHUD:self.view];

        // Check returning error
        if (retError) {
            NSString *errorMessage = @"SignIn failed.";
            NSString *detailedMessage = [KiiCommonUtilities errorDetailsMessage:retError];
            [KiiViewUtilities showFailureHUD:errorMessage withDetailsText:detailedMessage andView:self.view];
        } else {
            [self performSegueWithIdentifier:@"LoginCompleted" sender:self];
        }
    }];

    [KiiViewUtilities showProgressHUD:@"Processing..." withView:self.view];
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
