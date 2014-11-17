//
//  GroupListViewController.m
//  KiiTutorialApp
//
//  Created by Toshiyuki Oka on 11/10/14.
//  Copyright (c) 2014 Kii Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroupListViewController.h"
#import "KiiUserGroup.h"

@interface GroupListViewController () {
    NSArray *groupDatas;
    NSString* selectedData;
    NSDictionary *listDict;
    NSMutableArray *userGroups;
}
@end

@implementation GroupListViewController

- (void)viewDidLoad
{
    //static NSString *CellIdentifier = @"Cell";
    [super viewDidLoad];
    //groupDatas = [[NSArray alloc] initWithObjects:@"アトラエ", @"サイバーエージェント", @"Gunosy", @"リッチメディア", @"楽天", nil];
    userGroups = [[NSMutableArray alloc] init];
    [self loadInitialData];
}

- (void)loadInitialData {
    KiiUserGroup *group1 = [[KiiUserGroup alloc] init];
    group1.groupName = @"Atrae Inc.";
    [userGroups addObject:group1];
    KiiUserGroup *group2 = [[KiiUserGroup alloc] init];
    group2.groupName = @"KAIZEN platform Inc.";
    [userGroups addObject:group2];
    KiiUserGroup *group3 = [[KiiUserGroup alloc] init];
    group3.groupName = @"Rakuten Inc.";
    [userGroups addObject:group3];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [userGroups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListPrototypeCell" forIndexPath:indexPath];
    KiiUserGroup *userGroup = [userGroups objectAtIndex:indexPath.row];
    cell.textLabel.text = userGroup.groupName;
    return cell;
}

// Cell が選択された時
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath{
    selectedData = [groupDatas objectAtIndex:indexPath.row];
    // toViewController
    [self performSegueWithIdentifier:@"toConnectBLE" sender:self];
}

@end