//
//  GroupListViewController.m
//  KiiTutorialApp
//
//  Created by Toshiyuki Oka on 11/10/14.
//  Copyright (c) 2014 Kii Corporation. All rights reserved.
//

#import <KiiSDK/KiiBucket.h>
#import <KiiSDK/Kii.h>
#import "KiiCreateObjectViewController.h"
#import "KiiFileUploadViewController.h"
#import "KiiViewUtilities.h"
#import "KiiAppConstants.h"
#import "KiiCommonUtilities.h"
#import <Foundation/Foundation.h>
#import "GroupListViewController.h"
#import "KiiUserGroup.h"

@interface GroupListViewController () {
    NSArray *groupDatas;
    NSString* selectedData;
    NSDictionary *listDict;
    NSMutableArray *userGroups;
    NSString* groupName;
}
@end

@implementation GroupListViewController
@synthesize groupSearchField;

- (void)viewDidLoad
{
    //static NSString *CellIdentifier = @"Cell";
    [super viewDidLoad];
    //groupDatas = [[NSArray alloc] initWithObjects:@"アトラエ", @"サイバーエージェント", @"Gunosy", @"リッチメディア", @"楽天", nil];
    userGroups = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)loadInitialData {
    
    NSError *error;
    // Get the current login user
    KiiUser *user = [KiiUser currentUser];
    [user refreshSynchronous:&error];
    
    // Get a list of groups in which the current user is a member
    NSArray* memberGroups = [user memberOfGroupsSynchronous:&error];
    if (error == nil) {
        for (KiiGroup* membergroup in memberGroups) {
            // do something with each group
            KiiUserGroup* group = [[KiiUserGroup alloc] init];
            group.groupName = membergroup.name;
            [userGroups addObject:group];
            
            // Add user1 and user2 to the group
            [membergroup addUser:user];
            [membergroup saveSynchronous:&error];
            
            
            if (error != nil) {
                // Group add members failed
                // Please check error description/code to see what went wrong...
            }
        }
    } else {
        // Getting a group list failed
        // Please check error description/code to see what went wrong...
    }
}

- (IBAction)groupSearchButton:(id)sender{
    NSLog(@"%s","11111111");
    NSError *error;
    // Get the current login user
    KiiUser *user = [KiiUser currentUser];
    [user refreshSynchronous:&error];
    
    NSString *groupName = self.groupSearchField.text;
    NSLog(@"%@", groupName);
    
    // Get a list of groups in which the current user is a member
    //KiiGroup* group = [KiiGroup groupWithName: groupName];
    
    //[group addUser:user];
    //[group saveSynchronous:&error];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [userGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ( indexPath.row == 0 ) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"groupSearchCell" forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"groupListCell" forIndexPath:indexPath];
        KiiUserGroup *userGroup = [userGroups objectAtIndex:indexPath.row];
        cell.textLabel.text = userGroup.groupName;
    }
    return cell;
}

// Cell が選択された時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath{
    if (indexPath.row != 0){
        selectedData = [groupDatas objectAtIndex:indexPath.row];
        // toViewController
        [self performSegueWithIdentifier:@"toConnectBLE" sender:self];
    }else{
        NSLog(@"%s","2222222");
        return;
    }
}

@end
