//
//  ViewController.m
//  PassingDataForwar
//
//  Created by AlexZhang on 2018/4/10.
//  Copyright © 2018 Jixin. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerA.h"
#import "ViewControllerB.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *segueCellIdentifier = @"segueCellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Passing Data Between ViewControllers";
    [self configTableView];
    [self configDataSource];
}

- (void)configTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)configDataSource {
    self.dataArray = @[
                       @[@"Passing Data Forward",
                       @"Passing Data Back",
                       @"Passing Data UserDefaults"],
                       
                       @[@"Passing Data Forward using Segues"]
                       ];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    return headerView;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:segueCellIdentifier forIndexPath:indexPath];
    }
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    NSString *title = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataArray = self.dataArray[section];
    return dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        return;
    }
    NSArray *array = [self.dataArray objectAtIndex:indexPath.section];
    NSString *title = [array objectAtIndex:indexPath.row];

    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewControllerA *viewControllerA = [storyboard instantiateViewControllerWithIdentifier:@"ViewControllerA"];
    viewControllerA.titleString = title;
    viewControllerA.type = title;
    [self.navigationController pushViewController:viewControllerA animated:YES];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetail"]){
        ViewControllerB *controller = (ViewControllerB *)segue.destinationViewController;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        
        controller.textFieldContent = @"This view controller was pushed by segue";
        controller.hideTextField = YES;
        controller.hideBackButton = YES;
    }
}

@end
