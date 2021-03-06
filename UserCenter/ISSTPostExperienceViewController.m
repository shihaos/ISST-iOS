//
//  ISSTPostExperienceViewController.m
//  ISST
//
//  Created by zhangran on 14-7-12.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "ISSTPostExperienceViewController.h"
#import "ISSTUserCenterApi.h"
#import "MBProgressHUD.h"

@interface ISSTPostExperienceViewController ()<ISSTWebApiDelegate,MBProgressHUDDelegate>
{
    ISSTUserCenterApi *_userCenterApi;
    UITextField   *_titleTextField;
    UITextView  *_contentTextView;
    MBProgressHUD *HUD;
}
@end

@implementation ISSTPostExperienceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    _userCenterApi = [[ISSTUserCenterApi alloc] init];
    _userCenterApi.webApiDelegate= self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发布经验";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(sendExperience)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backToDetail)];
    [self initialize];
}

-(void)sendExperience
{
    if ([_titleTextField.text length]>0&&[_contentTextView.text length]>0) {
        //MBprogress
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.delegate = self;
        HUD.labelText = @"发送中...";
        [HUD show:YES];
        [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
        [_userCenterApi requestPostExperience:1 title:_titleTextField.text content:_contentTextView.text];
    }
    else if([_titleTextField.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"标题不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }
    else if([_contentTextView.text length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"内容不能为空" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }
}

-(void)initialize
{
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    titleLabel.text =@"标题:";
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:titleLabel];
    
    _titleTextField = [[UITextField alloc] init];
    _titleTextField.frame = CGRectMake(55, 2, 260, 35);
    [_titleTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.view addSubview:_titleTextField];
    
    //内容
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,titleLabel.bounds.origin.y +5+titleLabel.bounds.size.height+5, 50, 25)];
    contentLabel.text =@"内容:";
    [contentLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:contentLabel];
    
    _contentTextView = [[UITextView alloc] init ];
    _contentTextView.frame = CGRectMake(55, 45, 260, 200);
    _contentTextView.layer.borderWidth = 1;
    _contentTextView.layer.cornerRadius = 5;
    _contentTextView.layer.borderColor=[UIColor grayColor].CGColor;
  
    [self.view addSubview:_contentTextView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestDataOnSuccess:(id)backToControllerData
{
    NSString *message;
    if (backToControllerData) {
        
        [HUD hide:YES];
        message =@"发布成功!";
    }
    else
    {
        [HUD hide:YES];
        message =@"发布失败!";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您好:" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];

}

- (void)requestDataOnFail:(NSString *)error
{
    [HUD hide:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"异常" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];

}

- (void)backToDetail{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Execution code（MBProgressHUD）
- (void)myTask {
    // Do something usefull in here instead of sleeping ...可以增加一些逻辑代码
    sleep(3);
}


#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
