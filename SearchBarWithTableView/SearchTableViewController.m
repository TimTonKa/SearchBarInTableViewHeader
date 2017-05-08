//
//  SearchTableViewController.m
//  SearchBarWithTableView
//
//  Created by 1134 on 2017/5/5.
//  Copyright © 2017年 1134. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()
{
    NSMutableArray *list;
    NSArray *searchResult;
    UISearchController *mySearchController;
}

@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    list = [NSMutableArray new];
    [list addObject:@"iPhone"];
    [list addObject:@"iPad"];
    [list addObject:@"Apple TV"];
    [list addObject:@"iMac"];
    [list addObject:@"Apple Watch"];
    [list addObject:@"Mac Book"];
    
    mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    //設定哪個controller 要負責回應searchBar的更新
    mySearchController.searchResultsUpdater = self;
    
    //NO 代表搜尋時背景不要變暗
    mySearchController.dimsBackgroundDuringPresentation = NO;
    
    //searchBar default height 為0.0
    CGRect searchBarRect = mySearchController.searchBar.frame;
    searchBarRect.size.height = 44.0;
    mySearchController.searchBar.frame = searchBarRect;
    
    self.tableView.tableHeaderView = mySearchController.searchBar;
    
    //YES表示UISearchController 的畫面可以覆蓋目前的 controller
    self.definesPresentationContext = YES;
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
    
    //搜尋的到結果
    if (searchResult != nil) {
        return searchResult.count;
    }
    
    //搜尋不到結果就全show
    return list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (searchResult != nil) {
        cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [list objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (searchController.isActive) {
        NSString *searchString = searchController.searchBar.text;
        
        if (searchString.length > 0) {
            //［c］表示忽略大小写，［d］表示忽略重音，可以在一起使用
            NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchString];
            searchResult = [list filteredArrayUsingPredicate:p];
        } else {
            searchResult = nil;
        }
    } else {
        searchResult = nil;
    }
    
    [self.tableView reloadData];
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
