//
//  ViewController.m
//  TerrableTCellMode
//
//  Created by 肖冯敏 on 2021/8/27.
//

#import "ViewController.h"
#import "TTCViewModel.h"
#import "TTCTableViewCell.h"
#import "Masonry.h"


static NSString *cellIdentifity = @"cellIdentifity";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>* dataAry;

@property (nonatomic, strong) TTCViewModel *viewModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewModel = [[TTCViewModel alloc] init];
    _dataAry = [_viewModel nextPageData];
    
    // Do any additional setup after loading the view.
    [self initSubviews];
    [self masSubviews];
}

- (void)initSubviews {
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"需求变更" style:UIBarButtonItemStyleDone target:self action:@selector(changeData)];;
    
//    self.navigationController.navigationItem.rightBarButtonItem = rightItem;
//    [self.navigationController.navigationItem setRightBarButtonItem:rightItem];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[TTCTableViewCell class] forCellReuseIdentifier:cellIdentifity];
}

- (void)masSubviews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - Other

#pragma mark - TableView DataSource / Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = _dataAry[indexPath.row];
    TTCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifity];
    [cell updateDataWithDic:dict];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)changeData {
    _dataAry = [_viewModel nextPageData];
    [_tableView reloadData];
}

@end
