//
//  CallViewController.m
//  EEPCShop
//
//  Created by Mac Pro on 2019/10/11.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

#import "CallPhoneViewController.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface CallPhoneViewController ()

@property (nonatomic, strong) UIImageView  *backImage;
@property (nonatomic, strong) UILabel      *phone;
@property (nonatomic, strong) UILabel      *msg;
@property (nonatomic, strong) UIButton     *callback;


@end

@implementation CallPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.backImage = [[UIImageView alloc] init];
    self.backImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backImage.image = [UIImage imageNamed:@"call_bgimg"];
    [self.view addSubview:self.backImage];
    
    self.phone = [[UILabel alloc] init];
    self.phone.frame = CGRectMake((SCREEN_WIDTH - 200)/2, 80, 200, 30);
    self.phone.text = self.phoneNum;
    self.phone.textColor = [UIColor whiteColor];
    self.phone.textAlignment = NSTextAlignmentCenter;
    self.phone.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:self.phone];
    
    self.msg = [[UILabel alloc] init];
    self.msg.frame = CGRectMake((SCREEN_WIDTH - 250)/2, 120, 250, 30);
    self.msg.text = @"呼叫成功，请接听...";
    self.msg.textColor = [UIColor whiteColor];
    self.msg.textAlignment = NSTextAlignmentCenter;
    self.msg.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:self.msg];
    
    
    self.callback = [UIButton buttonWithType:UIButtonTypeCustom];
    self.callback.frame = CGRectMake((SCREEN_WIDTH - 300)/2, SCREEN_HEIGHT - 100, 300, 45);
    self.callback.backgroundColor = [UIColor redColor];
    [self.callback setTitle:@"返回" forState:UIControlStateNormal];
    [self.callback addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.callback];
    
}

- (void)back{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setHidden:false];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:true];

}
@end
