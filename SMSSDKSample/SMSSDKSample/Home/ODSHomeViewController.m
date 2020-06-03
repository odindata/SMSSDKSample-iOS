//
//  ODSHomeViewController.m
//  SMSSDKSample
//
//  Created by nathan on 2020/5/22.
//  Copyright © 2020 odin. All rights reserved.
//

#import "ODSHomeViewController.h"
#import "ODSTextField.h"
#import "ODSMSHeader.h"
#import "ODSResultViewController.h"
#import <OdinSMSSDK/OdinSMSSDK.h>
#import "MBProgressHUD+Extension.h"

@interface ODSHomeViewController ()

@property(nonatomic,strong)ODSTextField *phoneTextField;

@property(nonatomic,strong)ODSTextField *vcodeTextField;

@property(nonatomic,strong)UIButton *codeBtn;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)NSInteger times;

@end

@implementation ODSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"短信验证";
    self.times = 60;
    [self setupView];
}

- (void)setupView{
    UIImageView *leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_phone"]];
    self.phoneTextField = [[ODSTextField alloc]init];
    self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextField.leftView = leftView;
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    self.phoneTextField.placeholder = @"手机号";
    self.phoneTextField.frame = CGRectMake(21 * PUBLICSCALE, 96 + StaH + NavH, SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 53);
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneTextField];
    
    
    UIImageView *vodeLeftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_vcode"]];
    self.vcodeTextField = [[ODSTextField alloc]init];
    self.vcodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.vcodeTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.vcodeTextField.leftView = vodeLeftView;
    self.vcodeTextField.leftViewMode = UITextFieldViewModeAlways;
    self.vcodeTextField.placeholder = @"验证码";
    self.vcodeTextField.frame = CGRectMake(21 * PUBLICSCALE, 18 + CGRectGetMaxY(self.phoneTextField.frame),  210 * PUBLICSCALE, 53);
    [self.view addSubview:self.vcodeTextField];
    
    UIButton *codeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - (21 + 113) * PUBLICSCALE,self.vcodeTextField.frame.origin.y, 113 * PUBLICSCALE, 53)];
    _codeBtn = codeBtn;
    [codeBtn setTitle:@"获取验证码" forState:0];
    [codeBtn addTarget:self action:@selector(getVcodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [codeBtn setTitleColor:[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1] forState:0];
    codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    codeBtn.layer.borderWidth = .5;
    codeBtn.layer.cornerRadius = 2;
    codeBtn.layer.masksToBounds = YES;
    codeBtn.layer.borderColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1].CGColor;
    [self.view addSubview:codeBtn];
    
    
    UIButton *vBtn = [[UIButton alloc]initWithFrame:CGRectMake(21 * PUBLICSCALE, 36 + CGRectGetMaxY(codeBtn.frame), SCREEN_WIDTH - 2 * 21 * PUBLICSCALE, 53)];
    [vBtn addTarget:self action:@selector(vcodeResultAction:) forControlEvents:UIControlEventTouchUpInside];
    [vBtn setTitle:@"验证" forState:0];
    [vBtn setTitleColor:[UIColor whiteColor] forState:0];
    vBtn.layer.cornerRadius = 2;
    vBtn.layer.masksToBounds = YES;
    vBtn.backgroundColor = [UIColor colorWithRed:4/255.0 green:203/255.0 blue:148/255.0 alpha:1];
    [self.view addSubview:vBtn];
    
}

- (void)getVcodeAction:(UIButton *)sender{
    if (self.phoneTextField.text.length <= 0 || self.phoneTextField.text.length !=11) {
         [MBProgressHUD showTitle:@"请输入正确的手机号码"];
        return;
    }
    [self startimer];
    self.codeBtn.enabled = NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [OdinSMS getVerifyCodeWithMobile:self.phoneTextField.text templateId:nil codeType:OSMSCodeTypeText completion:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if (error)
            {
                [MBProgressHUD showTitle:@"发送失败"];
            }
            else
            {
                [MBProgressHUD showTitle:@"发送成功"];
            }
        });
    }];
}

- (void)vcodeResultAction:(UIButton *)sender{
    if (self.vcodeTextField.text.length<=0) {
        [MBProgressHUD showTitle:@"请输入验证码"];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [OdinSMS checkVerifyCode:self.vcodeTextField.text mobile:self.phoneTextField.text completion:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!error) {
                [self.navigationController pushViewController:[ODSResultViewController new] animated:YES];
            }else
                
            {
                [MBProgressHUD showTitle:@"验证失败"];
            }
        });
    }];
}

- (void)timerAction:(NSTimer *)sender{
    if (self.times <= 1) {
        [self stopTimer];
        [self.codeBtn setTitle:@"获取验证码" forState:0];
        self.codeBtn.enabled = YES;
        self.times = 60;
    }else{
        self.times--;
        [self.codeBtn setTitle:[NSString stringWithFormat:@"倒计时(%ld)",(long)self.times] forState:0];
    }
}

//开始计时
-(void)startimer{
    [self.timer fire];
}

//暂停并销毁
-(void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (NSTimer*)timer{
    if (!_timer) {
        _timer =[NSTimer scheduledTimerWithTimeInterval:1  target:self  selector:@selector(timerAction:) userInfo:nil  repeats:YES];
    }
    return _timer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
