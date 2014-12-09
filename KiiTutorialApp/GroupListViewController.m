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
    NSMutableArray *groupNameLists;
    NSString* groupName;
}
@end

@implementation GroupListViewController
@synthesize groupSearchField;
@synthesize groupSearchButton;

- (void)viewDidLoad
{
    //static NSString *CellIdentifier = @"Cell";
    [super viewDidLoad];
    //groupDatas = [[NSArray alloc] initWithObjects:@"アトラエ", @"サイバーエージェント", @"Gunosy", @"リッチメディア", @"楽天", nil];
    userGroups = [[NSMutableArray alloc] init];
    groupNameLists = [[NSMutableArray alloc] init];
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
            [groupNameLists addObject:[NSString stringWithFormat:@"%@",membergroup.name]];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [userGroups count];
}

-(void)btnClicked {
    NSLog(@"%s","11111111");
    NSError *error;
    // Get the current login user
    KiiUser *user = [KiiUser currentUser];
    [user refreshSynchronous:&error];
    
    groupName = groupSearchField.text;
    
    int groupIndex = [groupNameLists indexOfObject: groupName];
    if (groupIndex != 2147483647){
        //既存のgroupにジョインした場合
        KiiGroup* group = [KiiGroup groupWithName: groupName];
        
        // toViewController
        [self performSegueWithIdentifier:@"toConnectBLE" sender:self];
    }else{
        //新しくグループを作成した場合
        KiiGroup* group = [KiiGroup groupWithName: groupName];
        [group addUser:user];
        [group saveSynchronous:&error];
        
        // Create Application Scope Bucket
        KiiBucket *bucket = [Kii bucketWithName: groupName];
        // Create an object with key/value pairs
        
        KiiObject *object = [bucket createObject];
        
        [object setObject:[NSNumber numberWithInt: 0]
                   forKey:@"group_count"];
        [object setObject:object.uuid
                   forKey:@"object_id"];
        [object setObject:groupName
                   forKey:@"bucket_name"];
        
        // Save the object
        [object saveSynchronous:&error];
        // toViewController
        [self performSegueWithIdentifier:@"toConnectBLE" sender:self];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if ( indexPath.row == 0 ) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"groupSearchCell" forIndexPath:indexPath];
        
        groupSearchField = (UITextField*)[cell.contentView viewWithTag:3];
        groupSearchButton = (UIButton*)[cell.contentView viewWithTag:4];
        
        [groupSearchButton addTarget:self action:@selector(btnClicked)
        forControlEvents:UIControlEventTouchUpInside];
        [groupSearchButton setTitleColor: [UIColor blueColor] forState:
        UIControlStateNormal];
        [cell addSubview:groupSearchButton];
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
        KiiGroup *userGroup = [userGroups objectAtIndex:indexPath.row+1];
        // toViewController
        [self performSegueWithIdentifier:@"toConnectBLE" sender:self];
    }else{
        return;
    }
}

@end
