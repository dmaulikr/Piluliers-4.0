//
//  SettingsTableViewController.m
//  Piluliers 4.0
//
//  Created by Stoeckli Michael, IT133 on 13.05.17.
//  Copyright © 2017 Post CH AG. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"settings", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimelineDetailTableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = @"Mein Titel";
    cell.detailTextLabel.text = @"Mein Detail";
    cell.userInteractionEnabled = NO;
    return cell;
}

@end