//
//  XSMainTableViewController.m
//  XSNavigationBar
//
//  Created by dashuios126 on 2017/4/17.
//
//

#import "XSMainTableViewController.h"

#define  kSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define  kSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface XSMainTableViewController ()

@property (nonatomic,weak) UIView *headerView;
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UISearchBar *searchBar;



@end

@implementation XSMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//
//    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kSCREEN_WIDTH, 150)];
//    aView.backgroundColor = [UIColor blueColor];
//
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 44)];
//    title.text = @"首页";
//    [aView addSubview:title];
//
//    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 70, kSCREEN_WIDTH, 35)];
//    search.placeholder = @"搜索商品";
//
//    [aView addSubview:search];
//    self.tableView.tableHeaderView = aView;
//
//    self.titleLabel = title;
//    self.searchBar = search;
//    self.headerView = aView;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"xscell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

//    [self setHiddenNavgationBar];
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    NSLog(@"%f",scrollView.contentOffset.y);
//    CGFloat minAlphaOffset = -64;
//    CGFloat maxAlphaOffset = 64;
//
//    CGFloat header = 40.0;
//    CGFloat offY = scrollView.contentOffset.y;
//    CGFloat alpha = (offY - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
//    if (offY < header && offY > 0) {
//
//        [UIView animateWithDuration:0.1 animations:^{
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//            self.titleLabel.alpha = alpha;
//            self.headerView.alpha = alpha;
//            self.headerView.hidden = NO;
//            self.titleLabel.hidden = NO;
////            self.tableView.tableHeaderView = self.headerView;
//            [self setHiddenNavgationBar];
//
//        }];
//    }else if (offY >= header){
//        [UIView animateWithDuration:0.3 animations:^{
//            scrollView.contentInset = UIEdgeInsetsMake(-header, 0, 0, 0);
//            self.headerView.alpha = alpha;
//            self.titleLabel.hidden = YES;
//            self.headerView.hidden = YES;
////            self.tableView.tableHeaderView = [[UIView alloc]init];
//            [self SetShowNavgationBar];
//
//        }];
//    }else if (offY <= 0){
//        [UIView animateWithDuration:0.1 animations:^{
//            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
////            self.tableView.tableHeaderView = self.headerView;
//            self.titleLabel.hidden = NO;
//            self.titleLabel.alpha = 1;
//            self.headerView.alpha = 1;
//            self.headerView.hidden = NO;
//            [self setHiddenNavgationBar];
//
//        }];
//    }
//}

- (void)setHiddenNavgationBar{
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)SetShowNavgationBar {
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.title = @"首页";
//    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor blueColor]] forBarMetrics:UIBarMetricsDefault];

    UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 70, kSCREEN_WIDTH, 35)];
    search.placeholder = @"搜索商品";
    self.navigationController.navigationItem.titleView = search;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xscell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
