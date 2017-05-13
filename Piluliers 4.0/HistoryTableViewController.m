//
//  HistoryTableViewController.m
//  Piluliers 4.0
//
//  Created by Stoeckli Michael, IT133 on 12.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "TimelineTableViewCell.h"
#import "HistoryGraphView.h"
#import "UIColor+CustomColors.h"

@interface HistoryTableViewController ()

@property (nonatomic, weak) NSLayoutConstraint *topDistanceConstraint;

@end

@implementation HistoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"history", nil);
    
    HistoryGraphView *historyGraphView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HistoryGraphView class]) owner:self options:nil] firstObject];
    [historyGraphView setBackgroundColor:[UIColor hackathonAccentColor]];
    [self.navigationController.view addSubview:historyGraphView];
    historyGraphView.translatesAutoresizingMaskIntoConstraints = NO;
    [historyGraphView.heightAnchor constraintEqualToConstant:150].active = YES;
    self.topDistanceConstraint = [historyGraphView.topAnchor constraintEqualToAnchor:self.navigationController.view.topAnchor constant:[self getNavBarHeight]];
    self.topDistanceConstraint.active = YES;
    [historyGraphView.leftAnchor constraintEqualToAnchor:self.navigationController.view.leftAnchor].active = YES;
    [historyGraphView.rightAnchor constraintEqualToAnchor:self.navigationController.view.rightAnchor].active = YES;
    
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(150, 0, 0, 0)];
    [self.tableView setContentInset:UIEdgeInsetsMake(150, 0, 0, 0)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)getNavBarHeight {
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    return navigationBarHeight + statusBarHeight;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //todo stoecklim: make dynamic
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //todo stoecklim: make dynamic
    return 8;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //todo stoecklim: make dynamic
    return @"12.05.2017";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineTableViewCell *cell = (TimelineTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TimelineTableViewCell" forIndexPath:indexPath];
    //todo stoecklim: set data from model
    cell.intakeTime.text = @"12:00";
    cell.pillImage.image = [UIImage imageNamed:@"syrup"];
    [UIColor colorIconImageView:cell.pillImage color:[UIColor hackathonAccentColor]];
    cell.medicamentName.text = @"Medikament X";
    cell.medicamentDescription.text = @"Dies ist eine Pille";
    cell.medicamentDosage.text = @"1 Kapsel";
    cell.userInteractionEnabled = NO;
    return cell;
}

@end
