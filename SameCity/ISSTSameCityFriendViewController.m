//
//  ISSTSameCityFriendViewController.m
//  ISST
//
//  Created by rth on 14/12/5.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "ISSTSameCityFriendViewController.h"
#import "RESideMenu.h"

@interface ISSTSameCityFriendViewController ()

@end

@implementation ISSTSameCityFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"同城校友";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(21.0/255.0) green:(153.0 / 255.0) blue:(224.0 / 255.0) alpha:1];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"user.png"] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
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