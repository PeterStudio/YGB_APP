//
//  VersionUpdateView.h
//  CenterMarket
//
//  Created by dw on 14-7-14.
//  Copyright (c) 2014年 yurun. All rights reserved.
// 版本更新视图

#import <UIKit/UIKit.h>

@interface VersionUpdateView : UIView<UITableViewDataSource,UITableViewDelegate>{
    UIButton *sureBtn;      // 确定按钮
    UIButton *cancelBtn;    // 取消按钮
    UIView   *shadeView;  // 背景
}

@property (nonatomic, copy) dispatch_block_t leftBlock;  //确定按钮事件
@property (nonatomic, copy) dispatch_block_t rightBlock; //取消按钮事件
@property (nonatomic, strong)UITableView *tableView;    // 数据表
@property (nonatomic, strong)NSMutableArray *dataArray; // 数据源
/**
 *  初始化
 *
 *  @param docArr  更新数据
 *  @param _isMust 是否必要
 *
 *  @return self
 */
- (id)initWithDocArray:(NSArray *)docArr isMust:(BOOL)_isMust;

/**
 *  删除自身视图
 */
- (void)removeViewFromSelf;
@end
