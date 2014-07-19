//
//  SKStackSelectViewController.m
//  Stacks
//
//  Created by John Boiles on 7/18/14.
//  Copyright (c) 2014 Stacks. All rights reserved.
//

#import "SKStackSelectViewController.h"
#import "SKStack.h"
#import "SKStackManager.h"

@interface SKStackSelectViewController () <SKStackManagerDelegate>

@property (strong, nonatomic) NSArray *stacks;

@end

@implementation SKStackSelectViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.title = @"Your Stacks";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // TODO: Show progress UI
    [SKStackManager sharedStackManager].delegate = self;
    [[SKStackManager sharedStackManager] reloadStacks];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TODO: Support stack groups as sections in the UI
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stacks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StackCell"];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"StackCell"];
    }

    SKStack *stack = self.stacks[indexPath.row];
    cell.textLabel.text = stack.name;
    cell.detailTextLabel.text = stack.URLString;
    if ([stack isEqual:[[SKStackManager sharedStackManager] currentStack]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKStack *stack = self.stacks[indexPath.row];
    [[SKStackManager sharedStackManager] setCurrentStack:stack];
    [self.tableView reloadData];
}

#pragma mark SKStackManagers

- (void)stackManager:(SKStackManager *)stackManager didLoadStacks:(NSArray */*of Stack*/)stacks
{
    // TODO: If there are no stacks, show an empty message
    self.stacks = stacks;
    [self.tableView reloadData];
}

- (void)stackManager:(SKStackManager *)stackManager didError:(NSError *)error
{
    // TODO: Show an error
    NSLog(@"Error loading stacks: %@", error.localizedDescription);
}

@end
