# SMSSDKSample-iOS
奥丁SMSSDK示例demo
# OdinSMS集成
![Build Status](https://img.shields.io/badge/pod-0.0.3-blue.svg)
![Build Status](https://img.shields.io/badge/platform-iOS-dark.svg)

### OdinSMS是一个iOS的短信验证的SDK，集成十分简单。  

---

#### OdinSMS使用步骤
 1. [安装](#install)
 2. [申请AppKey](#appkey)
 3. [配置AppKey](#appkeyconfig)
 4. [具体功能使用](#wayofuse)
  
---

<h1 id="install">1.安装</h1>  

OdinSMS提供2种方式集成到工程中。
### 1.1 手动集成
在[奥丁数据开发者服务中心](http://www.stfukeyy.com/)或者[GitHub的Odin账号](https://github.com/odindata/OdinSMS)下载OdinSMSSDK.framework的最新版本，并添加到项目中。  

通过**Build Settings** > **Other Linker Flags**，添加
> -ObjC  

如下图所示：  
![image](https://github.com/BaconTimes/files/blob/master/images/odinpushbuildsetting.png?raw=true)

### 1.2 pod集成
#### 1.2.1 启动命令行工具，切换到工程目录下，如果项目之前没有使用pod集成，那么执行

```shell
$ pod init
```
该命令会在当前目录下生产对应的Podfile文件。

#### 1.2.2 在Podfile中添加
> pod 'OdinSMS'

#### 1.2.3 执行pod的集成命令

```shell
$ pod install
```
pod install成功后，可能报以下警告：

```
[!] The `OdinSMSDemo [Debug]` target overrides the `OTHER_LDFLAGS` build setting defined in `Pods/Target Support Files/Pods-OdinSMSDemo/Pods-OdinSMSDemo.debug.xcconfig'. This can lead to problems with the CocoaPods installation
    - Use the `$(inherited)` flag, or
    - Remove the build settings from the target.

[!] The `OdinSMSDemo [Release]` target overrides the `OTHER_LDFLAGS` build setting defined in `Pods/Target Support Files/Pods-OdinSMSDemo/Pods-OdinSMSDemo.release.xcconfig'. This can lead to problems with the CocoaPods installation
    - Use the `$(inherited)` flag, or
    - Remove the build settings from the target.
```

因为在Cocoapod里面会设置Other Linker Flags，而开发者之前也设置过，那么就会冲突，需要根据Cocoapod的提示，额外配置**Other Linker Flags**，添加  

> $(inherited)

如下图所示：

![image](https://github.com/BaconTimes/files/blob/master/images/SMS/odinsmsappinfo.jpg?raw=true)

#### 1.2.4 如果安装失败，提示原因是没有找到OdinSMS，那么执行以下命令更新本地库，然后再执行pod install

```shell
$ pod repo update
```
<h1 id="appkey">2.申请AppKey</h1>  

在[奥丁数据开发者服务中心](http://www.stfukeyy.com)申请并获得OdinSMS的**AppKey**。

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushappinfo.png?raw=true)






<h1 id="appkeyconfig">3.配置AppKey</h1>  

在工程的**info.plist**进行配置，AppKey对应plist的key是**OdinKey**，string类型。

```
<key>OdinKey</key>  
<string>填写你自己申请的AppKey</string>
```

<p align="center">
  <img src="https://github.com/BaconTimes/files/blob/master/images/odinpushprojinfo.png?raw=true" alt="OdinPush_info.plist" title="info.plist">
</p>

#### 网络请求权限配置  

由于OdinSMS的请求是http，需要运行app设置请求权限。源代码如下：

```
<key>NSAppTransportSecurity</key>  
<dict>  
<key>NSAllowsArbitraryLoads</key>  
<true/>  
</dict>  
```
开发者可以将上面代码直接加入到**info.plist**中。
或者自行添加，在info.plist最外层点击加号，添加新的键值对，key为**App Transport Security Settings**，类型为**Dictionary**，在刚添加的Dictionary下面添加键值对，key为**Allow Arbitrary Loads**，类型为**Boolean**，值为**YES**，如下图所示：  

![image](https://github.com/BaconTimes/files/blob/master/images/odinpushnetauth.png?raw=true)

<h1 id="wayofuse">4.具体功能使用</h1>  

OdinSMS 提供了3个API，如下所示：




额外说明：开发者可以在后台编辑短信的模板，保存后会获得模板ID，对应的就是下面的templateId，如果为空，那么就使用默认模板；而验证码的类型分为2种，分别为短信验证码和语音验证码，对应的就是下面的codeType。  
```
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
```

使用示例: 
```
[OdinSMS getVerifyCodeWithMobile:@"138****2314" templateId:nil codeType:codeType completion:^(NSError *error) {
    // 处理逻辑
}];

```

---

额外说明:无 
```
/**
 校验短信验证码

 @param verifyCode 收到的短信验证码
 @param mobile 接受验证码的手机号
 @param completion 校验验证码的回调
 */
+ (void)checkVerifyCode:(NSString *)verifyCode
                 mobile:(NSString *)mobile
             completion:(OSMSCompletion)completion;
```
使用示例：

```
[OdinSMS checkVerifyCode:@"123456" mobile:@"138****2314" completion:^(NSError *error) {
    //处理逻辑
}];
```

---
额外说明：下面的API嵌入了自定义UI，如果验证成功，则回调手机号。
```
/**
 使用默认的UI实现短信验证码登录

 @param completion 是否验证成功的回调
 */
+ (void)startVerifyUIWithCompletion:(OSMSUICompletion)completion;

```
