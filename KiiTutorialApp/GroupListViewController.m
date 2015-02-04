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
#import "MuscleGroup.h"
#import "AlertView.h"
#import "SVProgressHUD.h"
#import "ApiClient.h"
#import "AppUser.h"

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
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

    _groupSearchBar.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [self loadInitialData];
}

- (void)loadInitialData {
    // seiya api
    
    groupDatas = [[NSArray alloc] init];
    // for signup
    [SVProgressHUD show];
    [SVProgressHUD showWithStatus:@"loading..." maskType:SVProgressHUDMaskTypeGradient];

    AlertView *alertView = [AlertView new];
    ApiClient *api = [[ ApiClient alloc] initWithPath:@"/groups"];
    
    [api.manager GET:api.getUrl parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  [SVProgressHUD dismiss];
                  
                  NSMutableArray *dataLists = [NSMutableArray arrayWithArray:responseObject[@"groups"]];
                  
                  for (int i = 0; i < [dataLists count]; i++) {
                      MuscleGroup *muscleGroup = [[MuscleGroup alloc] initWithName:dataLists[i][@"name"] groupId:dataLists[i][@"id"]];
                      groupDatas = [groupDatas arrayByAddingObject: muscleGroup];
                  }
                  
                  [_tableView reloadData];
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [SVProgressHUD dismiss];
                  [alertView setTitle:@"Server Error"];
                  [alertView setText:@"通信でエラーが発生しました。再度試して下さい。"];
                  [self presentViewController:[alertView build] animated:YES completion:nil];
              }
     ];

    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"aaaaaaaaaaaaaa");
    
    
    
    //if( [searchText length] != 0 )
    //{
        
        //for(int i=0; i < groupDatas.count; i++){
        //    MuscleGroup *muscleGroup = groupDatas[i];
        //    NSRange range = [muscleGroup.name rangeOfString:searchText];

        //    if (range.location != NSNotFound) {
                
        //    }
        //}
        // インクリメンタル検索
    //}
}

- (void)filterContentForSearchText:(NSString*)searchString scope:(NSString*)scope {
    NSLog(@"START filterContentForSearchText"); // NOT CALLED...
 }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [groupDatas count];
}

-(void)btnClicked {
    NSError *error;
    // Get the current login user
    KiiUser *user = [KiiUser currentUser];
    [user refreshSynchronous:&error];
    
    groupName = groupSearchField.text;
    
    int groupIndex = [groupNameLists indexOfObject: groupName];
    if (groupIndex != 2147483647){
        //既存のgroupにジョインした場合
        KiiGroup* group = [KiiGroup groupWithName: groupName];
        
        //グループネームをNSUDに保存
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:groupName forKey:@"group_name"];
        
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
    
    NSLog(@"aaaaaaaaaaaaaaaaa");
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupListCell" forIndexPath:indexPath];
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:1];
    
        //KiiUserGroup *userGroup = [userGroups objectAtIndex:indexPath.row];
    MuscleGroup *muscleGroup = (MuscleGroup *)groupDatas[indexPath.row];
    nameLabel.text = muscleGroup.name;
    return cell;
}

// Cell が選択された時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath{
    [self performSegueWithIdentifier:@"toConnectBLE" sender:self];
}

- (IBAction)moveToGroupCreateView:(id)sender {
    [self performSegueWithIdentifier:@"groupCreateView" sender:self];
}



@end
