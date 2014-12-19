//
//  MiningHistoryTableViewCell.h
//  BZProject
//
//  Created by duwen on 14/12/19.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FreeForceHistoryModel.h"
@interface MiningHistoryTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

- (void)refrashDataWithFreeForceHistory:(FreeForceHistoryDetailModel *)freeForceHistoryModel;
@end
