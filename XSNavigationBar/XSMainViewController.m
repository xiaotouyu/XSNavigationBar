//
//  XSMainViewController.m
//  XSNavigationBar
//
//  Created by dashuios126 on 2017/4/17.
//
//

#import "XSMainViewController.h"
#import "XSMainTableViewController.h"
#import "PYSearch.h"

#define  kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define  kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface XSMainViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,PYSearchViewControllerDelegate>

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIView *headerView;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UISearchBar *searchBar;



@property (nonatomic,strong) UISearchController *searchViewController;
@property (strong,nonatomic) NSMutableArray  *searchList;




@end

@implementation XSMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH, 150)];
    aView.backgroundColor = [UIColor blueColor];


    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 70, kSCREEN_WIDTH-10, 44)];
    search.placeholder = @"搜索商品";
    search.delegate = self;
    search.backgroundColor = [UIColor clearColor];
    [aView addSubview:search];

    [self setHiddenLine:search];
    [self.view addSubview:aView];



    UITableView *aTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStylePlain];
    aTableView.delegate = self;
    aTableView.dataSource = self;
    aTableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:aTableView];

    [aTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    self.searchBar = search;
    self.headerView = aView;
    self.tableView = aTableView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self setHiddenNavgationBar];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {

    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];

    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {

        NSLog(@"searchViewControllerWithHotSearches %@",searchText);
        [searchViewController.navigationController pushViewController:[[XSMainTableViewController alloc] init] animated:YES];

    }];
    searchViewController.hotSearchStyle = 0;
    searchViewController.searchHistoryStyle = 1;
    searchViewController.searchResultShowMode = PYSearchResultShowModeDefault;

    searchViewController.delegate = self;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    nav.navigationBar.tintColor = [UIColor whiteColor];
    nav.navigationBar.barTintColor = [UIColor blueColor];
    [self presentViewController:nav animated:YES completion:nil];

}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.y);

//
    CGFloat header = 40.0;
    CGFloat offY = scrollView.contentOffset.y;
    if (offY < header && offY > 0) {

        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            [self.headerView addSubview:self.searchBar];
            self.searchBar.alpha = 1.0;
            self.headerView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 150-offY);
            self.searchBar.frame = CGRectMake(10, 150-offY-64, kSCREEN_WIDTH-10, 44);
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kSCREEN_WIDTH, kSCREEN_HEIGHT);
        }];
    }else if (offY >= header){
        [UIView animateWithDuration:0.3 animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(-header, 0, 0, 0);
            self.headerView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 64);
            self.searchBar.frame = CGRectMake(10, 24, kSCREEN_WIDTH-10, 44);
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kSCREEN_WIDTH, kSCREEN_HEIGHT);

            [UIView animateWithDuration:0.3 animations:^{

                self.searchBar.alpha = 0.5;
            } completion:^(BOOL finished) {

                [self.searchBar removeFromSuperview];
                self.searchBar.alpha = 1.0;
                [self.navigationController.view addSubview:self.searchBar];
            }];
        }];
    }else if (offY <= 0){
        [UIView animateWithDuration:0.5 animations:^{
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            self.searchBar.alpha = 1.0;
            [self.headerView addSubview:self.searchBar];
            self.headerView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, 150);
            self.searchBar.frame = CGRectMake(10, 70, kSCREEN_WIDTH-10, 44);
            self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kSCREEN_WIDTH, kSCREEN_HEIGHT);
        }];
    }

}

/**
 去除搜索栏的背景框

 */
- (void)setHiddenLine:(UISearchBar *)bar{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if ([bar respondsToSelector:@selector(barTintColor)]) {
        float iosversion7_1 = 7.1;
        if (version >= iosversion7_1){

            [[[[bar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
            [bar setBackgroundColor:[UIColor clearColor]];

        }else {            //iOS7.0

            [bar setBarTintColor:[UIColor clearColor]];
            [bar setBackgroundColor:[UIColor clearColor]];
        }
    }else {
        //iOS7.0以下
        [[bar.subviews objectAtIndex:0] removeFromSuperview];

        [bar setBackgroundColor:[UIColor clearColor]];
    }
}
- (void)setHiddenNavgationBar{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}


- (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.searchViewController.active ? self.searchList.count : 10;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    XSMainTableViewController *vc = [[XSMainTableViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
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
