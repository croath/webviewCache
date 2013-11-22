//
//  MainViewController.m
//  h5test
//
//  Created by lihejun on 13-11-21.
//  Copyright (c) 2013年 芈峮. All rights reserved.
//

#import "MainViewController.h"
#import "ActionsView.h"
#import "URLManager.h"
#import "MainCell.h"
#import "EditViewController.h"
#import "TestViewController.h"

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)ActionsView *actionsView;
@property (nonatomic, strong)UITableView *contentTableView;
@end

@implementation MainViewController
@synthesize actionsView = _actionsView, contentTableView = _contentTableView;

#pragma mark - Getters
- (ActionsView *)actionsView{
    if (!_actionsView) {
        _actionsView = [ActionsView actionsView:self];
        [self.view addSubview:_actionsView];
    }
    return _actionsView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[URLManager shareManager] storeToDisk];
}

- (void)viewWillAppear:(BOOL)animated{
    if (!_contentTableView) {
        //table view
        CGRect r = self.actionsView.frame;
        if (IOS_NEWER_OR_EQUAL_TO_7) {
            r.origin.y = 20 + 44;
        }
        self.actionsView.frame = r;
        r = self.view.frame;
        r.origin.y = self.actionsView.frame.origin.y + self.actionsView.frame.size.height;
        r.size.height -= r.origin.y;
        _contentTableView = [[UITableView alloc] initWithFrame:r];
        [_contentTableView setDataSource:self];
        [_contentTableView setDelegate:self];
        [self.view addSubview:_contentTableView];
        [self.view addSubview:self.actionsView];
    }
    [_contentTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[URLManager shareManager].urls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    if (!cell) {
        cell = [MainCell mainCell];
    }
    ((MainCell *)cell).title.text = [[URLManager shareManager].urls objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TestViewController *controller = [[TestViewController alloc] init];
    NSMutableArray * testurls = [[NSMutableArray alloc] init];
    [testurls addObject: [[URLManager shareManager].urls objectAtIndex:indexPath.row] ];
    controller.urls = testurls;
    controller.type = self.actionsView.type;
    [self.navigationController pushViewController:controller animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [[URLManager shareManager].urls removeObjectAtIndex:indexPath.row];
        [[URLManager shareManager] storeToDisk];
        [tableView reloadData];
    }
}

#pragma mark - Actions

- (void)allSend{
    TestViewController *controller = [[TestViewController alloc] init];
    controller.urls = [[URLManager shareManager].urls copy];
    controller.type = self.actionsView.type;
    [self.navigationController pushViewController:controller animated:YES];
}


@end
