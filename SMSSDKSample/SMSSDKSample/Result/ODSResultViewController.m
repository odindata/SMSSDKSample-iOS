//
//  ODSResultViewController.m
//  SMSSDKSample
//
//  Created by nathan on 2020/5/23.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODSResultViewController.h"
#import "ODSMSHeader.h"

@interface ODSResultViewController ()

@end

@implementation ODSResultViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView{
    
    UIImageView *bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v_bg"]];
    bgImgView.frame = self.view.bounds;
    [self.view addSubview:bgImgView];
    
    UIImage *tipImg = [UIImage imageNamed:@"v_success"];
    UIImageView *tipImgView = [[UIImageView alloc]initWithImage:tipImg];
    tipImgView.frame = CGRectMake((SCREEN_WIDTH - tipImg.size.width)/2.0, 88, tipImg.size.width, tipImg.size.height);
    [self.view addSubview:tipImgView];
    
    UILabel *successlbl = [[UILabel alloc]init];
    successlbl.text = @"验证成功";
    successlbl.textColor = [UIColor whiteColor];
    successlbl.font = [UIFont boldSystemFontOfSize:13];
    successlbl.frame = CGRectMake(0, 23 + CGRectGetMaxY(tipImgView.frame), SCREEN_WIDTH, 22);
    successlbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:successlbl];
    
    UIButton *retryBtn = [[UIButton alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 284 + CGRectGetMaxY(successlbl.frame),SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 53)];
    [retryBtn setTitle:@"重新验证" forState:0];
    [retryBtn setTitleColor:[UIColor blackColor] forState:0];
    [retryBtn setBackgroundColor:[UIColor colorWithRed:245/255.0 green:247/255.0 blue:249/255.0 alpha:1]];
    retryBtn.layer.cornerRadius = 4;
    retryBtn.layer.masksToBounds = YES;
    retryBtn.layer.borderWidth = 1;
    retryBtn.layer.borderColor = [UIColor colorWithRed:167/255.0 green:182/255.0 blue:199/255.0 alpha:1].CGColor;
    [retryBtn addTarget:self action:@selector(retryAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:retryBtn];
}

- (void)retryAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
