//
//  MiningHistoryTableViewCell.m
//  BZProject
//
//  Created by duwen on 14/12/19.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "MiningHistoryTableViewCell.h"

@implementation MiningHistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _timeLabel.text = @"";
    _numberLabel.text = @"";
}

- (void)refrashDataWithFreeForceHistory:(FreeForceHistoryDetailModel *)freeForceHistoryModel{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[freeForceHistoryModel.time doubleValue]];
    _timeLabel.text = [formatter stringFromDate:date];
    
    float one = [freeForceHistoryModel.dwygb doubleValue];
    float two = [freeForceHistoryModel.sl doubleValue];
    _numberLabel.text = [self notRounding:one*two afterPoint:6];
}

-(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
