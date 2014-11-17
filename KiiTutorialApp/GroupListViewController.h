//
//  GroupListViewController.h
//  KiiTutorialApp
//
//  Created by Toshiyuki Oka on 11/10/14.
//  Copyright (c) 2014 Kii Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *groups;

+ (id)userGroupList;

@end