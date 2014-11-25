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

@interface KiiCreateObjectViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *descView;
@end

@implementation KiiCreateObjectViewController

@synthesize groupNameField;

- (void)viewDidLoad {
    [KiiViewUtilities showSuccessHUD:@"Login success" withView:self.view];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(descViewTaped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.descView addGestureRecognizer:singleTap];
    [self.descView setUserInteractionEnabled:YES];
}

- (IBAction)mCreateKiiObjectButton:(id)sender {
    NSError *error;
    NSString *enteredText = self.groupNameField.text;
    NSString *groupName = enteredText;
    
    KiiGroup* group = [KiiGroup groupWithName:groupName];
    [group saveSynchronous:&error];
    // Add user1 and user2 to the group
    KiiUser *user = [KiiUser currentUser];
    [group addUser:user];
    [group saveSynchronous:&error];
    
    if (error != nil) {
        // Group creation failed
        // Please check error description/code to see what went wrong...
        [KiiViewUtilities showFailureHUD:@"KiiObject creation is failed." withView:self.view];
        NSLog(@"ERROR!!");
    } else {
        [self performSegueWithIdentifier:@"CreateObjectCompleted" sender:self];
        NSLog(@"SUCCESS1!!");
    }
    
    // Get the reference URI.
    NSString *groupUri = [group objectURI];
    
    // Get the reference ID.
    //NSString *groupID = [group groupID];
    
    //NSLog(groupID);
    
    //KiiBucket *bucket = [Kii bucketWithName:@"Group"]; //KII_APP_BUCKET_NAME
    //KiiObject *object = [bucket createObject];
    //[object setObject:[KiiUser currentUser].username forKey:@"username"];
    //[object saveWithBlock:^(KiiObject *retObject, NSError *retError) {
    //    [KiiViewUtilities hideProgressHUD:self.view];
    //    if (retError) {
    //        [KiiViewUtilities showFailureHUD:@"KiiObject creation is failed." withView:self.view];
    //    } else {
    //        self.kiiObject = retObject;
    //        [self performSegueWithIdentifier:@"CreateObjectCompleted" sender:self];
    //    }
    //}];
    [KiiViewUtilities showProgressHUD:@"Create KiiObject..." withView:self.view];
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
