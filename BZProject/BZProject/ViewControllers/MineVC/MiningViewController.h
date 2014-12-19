//
//  MiningViewController.h
//  BZProject
//
//  Created by duwen on 14/12/13.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "BZViewController.h"
#import "UserFundsModel.h"
@interface MiningViewController : BZViewControllerWithBackButton<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UserFundsDetailModel * fundsModel;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;


@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@property (strong, nonatomic) UITableViewCell *prototypeCell;
@property (strong, nonatomic) NSMutableArray * dataSourceArray;

@end
