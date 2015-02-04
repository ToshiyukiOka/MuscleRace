//
//  GroupListViewController.h
//  KiiTutorialApp
//
//  Created by Toshiyuki Oka on 11/10/14.
//  Copyright (c) 2014 Kii Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KiiSDK/KiiObject.h>

@interface GroupListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, nonatomic) IBOutlet UITextField *groupSearchField;
@property (nonatomic, strong) IBOutlet UIButton *groupSearchButton;

@property (strong, nonatomic) IBOutlet UISearchBar *groupSearchBar;


+ (id)userGroupList;

@end