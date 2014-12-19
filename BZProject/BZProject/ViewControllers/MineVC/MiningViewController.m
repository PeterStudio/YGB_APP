//
//  MiningViewController.m
//  BZProject
//
//  Created by duwen on 14/12/13.
//  Copyright (c) 2014年 peterstudio. All rights reserved.
//

#import "MiningViewController.h"
#import "SVProgressHUD.h"
#import "MiningService.h"
#import "MiningModel.h"
#import "LoginManager.h"
#import "LoginModel.h"
#import "FreeGetForceService.h"
#import "FreeGetForceModel.h"
#import "FreeForceHistoryService.h"
#import "FreeForceHistoryModel.h"
#import "MiningHistoryTableViewCell.h"
static NSString *cellIndentifier = @"MiningHistoryTableViewCellIndentifierlalal";

@interface MiningViewController ()
@property (nonatomic, strong) MiningService * miningService;
@property (nonatomic, strong) FreeGetForceService * freeGetForceService;
@property (nonatomic, strong) FreeForceHistoryService * freeForceHistoryService;
@end

@implementation MiningViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myFundsHaveUpdate:) name:@"UPDATEUSERFUNDS" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UPDATEUSERFUNDS" object:nil];
}

- (void)config{
    _firstLabel.text = _fundsModel.total_pow;
    _secondLabel.text = _fundsModel.total_ygb;
    _thirdLabel.text = _fundsModel.pow;
    _fourLabel.text = _fundsModel.ygb;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:UIColorFromRGB(0xf5f5f5)];
    
    UINib *cellNib = [UINib nibWithNibName:@"MiningHistoryTableViewCell" bundle:nil];
    [_mainTableView registerNib:cellNib forCellReuseIdentifier:cellIndentifier];
    self.prototypeCell  = [_mainTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    [self setRightBarButtonItem];
    [self config];
    self.miningService = [[MiningService alloc] init];
    self.freeGetForceService = [[FreeGetForceService alloc] init];
    self.freeForceHistoryService = [[FreeForceHistoryService alloc] init];
    self.dataSourceArray = [[NSMutableArray alloc] init];
    
    [self miningRequest];
    [self freeForceHistoryRequest];
}

/**
 *  设置导航栏右注册按钮
 */
- (void)setRightBarButtonItem
{
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if (CURRENT_VERSION < 7.0) {
        [editButton setFrame:CGRectMake(0, 0, 40 + 22 + 31 * 3, 20)];
    } else {
        [editButton setFrame:CGRectMake(0, 0, 40 + 60, 20)];
    }
    [editButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [editButton setTitle:@"免费领算力" forState:UIControlStateNormal];
    [editButton setTitle:@"免费领算力" forState:UIControlStateHighlighted];
    [editButton setTitleColor:UIColorFromRGB(0xe1190b) forState:UIControlStateNormal];
    [editButton setTitleColor:UIColorFromRGB(0xcc170a) forState:UIControlStateHighlighted];
    editButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [editButton addTarget:self action:@selector(gotFreeYGB) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

/**
 *  免费领算力
 */
- (void)gotFreeYGB{
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    [self.freeGetForceService freeGetForce_Request_HTTP_MemberID:loginModel.id success:^(id responseObject) {
        [SVProgressHUD dismiss];
        FreeGetForceModel * freeGetForceModel = (FreeGetForceModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:freeGetForceModel.status]) {
            FreeGetForceDetailModel * freeGetForceDetailModel = (FreeGetForceDetailModel *)freeGetForceModel.data;
            _firstLabel.text = freeGetForceDetailModel.total_pow;
            _secondLabel.text = freeGetForceDetailModel.total_ygb;
            _thirdLabel.text = freeGetForceDetailModel.pow;
            _fourLabel.text = freeGetForceDetailModel.ygb;
        }
        [SVProgressHUD showErrorWithStatus:freeGetForceModel.info];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}


/**
 *  挖矿
 */
- (void)miningRequest{
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    [SVProgressHUD showWithStatus:@"加载中" maskType:SVProgressHUDMaskTypeGradient];
    [self.miningService mining_Request_HTTP_UserID:loginModel.id type:@"0" success:^(id responseObject) {
        [SVProgressHUD dismiss];
        MiningModel * miningModel = (MiningModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:miningModel.status]) {
            [SVProgressHUD showErrorWithStatus:@"开始挖矿成功，退出登录则停止挖矿。"];
        }else{
            [SVProgressHUD showErrorWithStatus:miningModel.info];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:OTHER_ERROR_MESSAGE];
    }];
}

/**
 *  算力历史纪录
 */
- (void)freeForceHistoryRequest{
    LoginDetailModel * loginModel = [[LoginManager shareInstance] loginAccountInfo];
    [self.freeForceHistoryService freeForceHistory_Request_HTTP_MemberID:loginModel.id success:^(id responseObject) {
        FreeForceHistoryModel * ffhModel = (FreeForceHistoryModel *)responseObject;
        if ([RETURN_CODE_SUCCESS isEqualToString:ffhModel.status]) {
            [self.dataSourceArray addObjectsFromArray:ffhModel.data];
            _tableViewHeightConstraint.constant = 44 * self.dataSourceArray.count;
            [self.mainTableView reloadData];
            [self showAnimateWhenChangeConstraint];
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)myFundsHaveUpdate:(NSNotification *)noti{
    _fundsModel = (UserFundsDetailModel *)noti.object;
    [self config];
    NSLog(@"5min come on");
}

- (void)showAnimateWhenChangeConstraint{
    [self.view setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.35f animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSourceArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MiningHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell refrashDataWithFreeForceHistory:(FreeForceHistoryDetailModel *)self.dataSourceArray[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
