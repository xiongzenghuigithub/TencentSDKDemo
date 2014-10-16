

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface TencentApiManager : NSObject <TencentSessionDelegate>

+ (TencentApiManager *)getInstance;

+ (BOOL)isLoign;

//分享
+ (void)shareTextMsg:(NSString *)msg;
+ (void)sharePicMsg:(NSString *)imageName;
+ (void)shareNews;
+ (void)shareAudio;
+ (void)shareVideo;

//QZone Api
/*
 1)由QQ自己的API发送异步请请求获取服务器数据.
 2)API所示的回调函数中获取APIResponse. 
 3)将APIResponse对象以字典的形式存放到通知的userInfo属性
 */
+ (void)getUserInfo;    //获取用户QQ空间的基本信息
+ (void)uploadPhoto:(NSData *)imageData;
+ (void)getListalbum;   //获取用户QQ空间的相册列表 (需要高级权限)

//Alert View
+ (void)showAlertView:(NSString *)title message:(NSString *)msg;
+ (void)showInvalidTokenOrOpenIDMessage;
+ (void)showNotLogin;

@property(nonatomic, copy) NSString * accessToken;
@property(nonatomic, copy) NSString * openId;
@property(nonatomic, copy) NSDate* expirationDate;

@property (nonatomic, retain) TencentOAuth * oauth;
@property (nonatomic, retain) NSMutableArray* photos;
@property (nonatomic, retain) NSMutableArray* thumbPhotos;

@end
