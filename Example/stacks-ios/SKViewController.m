//
//  SKViewController.m
//  stacks-ios
//
//  Created by John Boiles on 07/18/2014.
//  Copyright (c) 2014 John Boiles. All rights reserved.
//

#import "SKViewController.h"
#import <SKStackSelectViewController.h>
#import <SKStackManager.h>
#import <SKStack.h>

@interface SKViewController ()
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *appIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *URLLabel;

@end

@implementation SKViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    SKStack *currentStack = [SKStackManager sharedStackManager].currentStack;
    self.idLabel.text = currentStack.URLString;
    self.appIdLabel.text = currentStack.appId;
    self.groupLabel.text = currentStack.group;
    self.nameLabel.text = currentStack.name;
    self.URLLabel.text = currentStack.URLString;
}

- (IBAction)showStackSelection:(id)sender {
    SKStackSelectViewController *viewController = [[SKStackSelectViewController alloc] init];
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(dismissModal)];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)dismissModal {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
