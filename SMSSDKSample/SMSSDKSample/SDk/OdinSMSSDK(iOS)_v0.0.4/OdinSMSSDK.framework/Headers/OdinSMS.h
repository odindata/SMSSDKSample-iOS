//
//  OdinSMS.h
//  OdinSMSSDK
//
//  Created by isec on 2019/7/3.
//  Copyright © 2019 isec. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 发送验证码的类型

 - OSMSCodeTypeText: 短信验证码
 - OSMSCodeTypeVoice: 语音验证码 ！！！当前版本暂不支持！！！
 */
typedef NS_ENUM(NSUInteger, OSMSCodeType) {
    OSMSCodeTypeText,
//    OSMSCodeTypeVoice,
};


typedef void(^OSMSCompletion)(NSError *error);


/**
 UI操作的回调

 @param error 回调的错误信息
 @param mobile 用户填写的手机号
 */
typedef void(^OSMSUICompletion)(NSError *error, NSString *mobile);

@interface OdinSMS : NSObject

/**
 获取短信验证码

 @param mobile 待验证的手机号
 @param templateId 短信模板的id
 @param codeType 验证码的类型
 @param completion 获取短信验证码的回调
 */
+(void)getVerifyCodeWithMobile:(NSString *)mobile
                    templateId:(NSString *)templateId
                      codeType:(OSMSCodeType)codeType
                   completion:(OSMSCompletion)completion;

/**
 校验短信验证码

 @param verifyCode 收到的短信验证码
 @param mobile 接受验证码的手机号
 @param completion 校验验证码的回调
 */
+ (void)checkVerifyCode:(NSString *)verifyCode
                 mobile:(NSString *)mobile
             completion:(OSMSCompletion)completion;

/**
 使用默认的UI实现短信验证码登录

 @param completion 是否验证成功的回调
 */
+ (void)startVerifyUIWithCompletion:(OSMSUICompletion)completion;

@end
