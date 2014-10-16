
#import "TencentApiManager.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "TencenApiDef.h"

@class QQBaseReq;
@class QQBaseResp;

@implementation TencentApiManager

static TencentApiManager *apiManager = nil;
+ (TencentApiManager *)getInstance {
    if (apiManager == nil) {
        apiManager = [[TencentApiManager alloc] init];
    }
    return apiManager;
}

- (id)init {

    
    //XZH 实例化TencentOAuth登陆认证对象
    _oauth = [[TencentOAuth alloc] initWithAppId:kQQAppKey andDelegate:self];
    
    return self;
}

+ (BOOL)isLogin {
    
    if ([[TencentApiManager getInstance] accessToken] == nil) {
        return NO;
    }else {
        return YES;
    }
}

+ (void)shareTextMsg:(NSString *)msg {
    
    NSLog(@"\n  分享有链接的文本信息.... \n");
    
    if ([self isLogin]) {
        
        QQApiURLObject *obj2 = [QQApiURLObject objectWithURL:[NSURL URLWithString:@"wwww.baidu.com"] title:@"哈哈的分享" description:@"分享的详细描述" previewImageURL:nil targetContentType:QQApiURLTargetTypeNotSpecified ];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj2];
        [QQApiInterface sendReq:req];
//        [QQApiInterface SendReqToQZone:req];
        //    QQApiSendResultCode *code = [QQApiInterface sendReq:req];
        
    }else{
        
        [self showNotLogin];
    }
    
}

+ (void)sharePicMsg:(NSString *)imageName {
    
    NSLog(@"\n  分享纯图片信息.... \n");
    
    if ([self isLogin]) {
        
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"sharePic" ofType:@"png"];
        NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"sharePic.png"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        QQApiImageObject *obj = [QQApiImageObject objectWithData:data previewImageData:data title:@"分享图片信息" description:@"分享图片信息" imageDataArray:@[data]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
        [QQApiInterface sendReq:req];
//        [QQApiInterface SendReqToQZone:req];
        //    QQApiSendResultCode *code = [QQApiInterface sendReq:obj];
        
    }else {
        
        [self showNotLogin];
    }
}

+ (void)shareNews {
    
    NSString *utf8String = @"http://www.163.com";
    NSString *title = @"新闻标题";
    NSString *description = @"新闻描述";
    NSString *previewImageUrl = @"http://cdni.wired.co.uk/620x413/k_n/NewsForecast%20copy_620x413.jpg";
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL:[NSURL URLWithString:utf8String]
                                title:title
                                description:description
                                previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    //QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    //将内容分享到qzone
    QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
}

+ (void)shareAudio {
    NSString *utf8String = @"http://y.qq.com/i/song.html?songid=432451&source=mobileQQ%23wechat_redirect";
    NSString *title = @"歌曲名：不要说话";
    NSString *descriotion = @"专辑名：不想放手歌手名：陈奕迅";
    NSString *previewImageUrl = @"http://imgcache.qq.com/music/photo/mid_album_300/V/E/000J1pJ50cDCVE.jpg";

    QQApiAudioObject *audioObj =
    [QQApiAudioObject objectWithURL:[NSURL URLWithString:utf8String]
                              title:title
                        description:descriotion
                    previewImageURL:[NSURL URLWithString:previewImageUrl]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
    
    //将内容分享到qq
    QQApiSendResultCode sent1 = [QQApiInterface sendReq:req];
    //将被容分享到qzone
//    QQApiSendResultCode sent2 = [QQApiInterface SendReqToQZone:req];
}

+ (void)shareVideo {
    
    NSString *previewPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"previewImage.jpg"];
    NSData* previewData = [NSData dataWithContentsOfFile:previewPath];
    
     //分享网络视频
    NSURL *videoURL = [NSURL URLWithString:@"http://v.youku.com/v_show/id_XODAzNjY5MTY4.html?f=22934635&ev=2&from=y1.3-idx-grid-1519-9909.86808-86807.2-1"];
    QQApiVideoObject *videoObj = [QQApiVideoObject objectWithURL:videoURL
                                                            title:@"QQ互联测试"
                                                      description:@"QQ互联测试分享"
                                                 previewImageData:previewData];
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
    
    
    //将内容分享到qq
    QQApiSendResultCode sent1 = [QQApiInterface sendReq:req];
    
    //将被容分享到qzone
//    QQApiSendResultCode sent2 = [QQApiInterface SendReqToQZone:req];
}

#pragma mark - QZone Api
+ (void)getUserInfo {
    
    if ([[[TencentApiManager getInstance] oauth] getUserInfo] == NO) {//发送请求后, 异步回调getUserInfoResponse:函数
        [TencentApiManager showInvalidTokenOrOpenIDMessage];
    }
}

+ (void)getListalbum {
    
    if([[[TencentApiManager getInstance] oauth] getListAlbum] == NO) {
        [TencentApiManager showInvalidTokenOrOpenIDMessage];
    }
}

+ (void)uploadPhoto:(NSData *)imageData {
    
}

#pragma mark - Alert view

+ (void)showAlertView:(NSString *)title message:(NSString *)msg{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)showInvalidTokenOrOpenIDMessage {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败" message:@"可能授权已过期，请重新获取" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)showNotLogin {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"没有登陆QQ" message:@"请先登陆QQ然后分享" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}





#pragma mark - TencentSessionDelegate
- (void)tencentDidLogin {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessed object:self];
    
    //XZH 登陆成功后获取用户的token
    self.accessToken = [[[TencentApiManager getInstance] oauth] accessToken];
    self.expirationDate = [[[TencentApiManager getInstance] oauth] expirationDate];
    self.openId = [[[TencentApiManager getInstance] oauth] openId];
    
    [[NSUserDefaults standardUserDefaults] setValue:self.accessToken forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] setValue:self.expirationDate forKey:@"expirationDate"];
    [[NSUserDefaults standardUserDefaults] setValue:self.openId forKey:@"openId"];
    
    NSLog(@"\n-------------登陆成功--------------\n");
    NSLog(@"self.accessToken = %@\n" , self.accessToken);
    NSLog(@"self.expirationDate = %@\n", self.expirationDate);
    NSLog(@"\n----------------------------------\n");
}

- (void)tencentDidLogout {

}

- (void)tencentDidNotLogin:(BOOL)cancelled {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (void)tencentDidNotNetWork {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (void)getUserInfoResponse:(APIResponse*) response {
    
    //XZH object标签 -- 知道kGetUserInfoResponse名字的通知， 只有该object设置的对象才能接受到
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetUserInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)getListAlbumResponse:(APIResponse*) response {
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetListAlbumResponse object:[TencentApiManager getInstance] userInfo:[NSDictionary dictionaryWithObjectsAndKeys: response, kResponse, nil]];
}

#pragma mark - QQApiInterfaceDelegate (处理来至QQ的请求及响应的回调协议)
- (void)onReq:(QQBaseReq *)req {

}

- (void)onResp:(QQBaseResp *)resp {
    
}

- (void)isOnlineResponse:(NSDictionary *)response {
    
}

#pragma mark - 接受腾讯服务器回调response通知 的方法
- (void)didGetResponseFromNotification:(NSNotification *)notify {
    
    if (notify) {
        
        //XZH 从NSNotification.userInfo中取出NSDictionary(key:kResponse, value:APIResponse对象)
        APIResponse *response = [[notify userInfo] objectForKey:kResponse];
        
        if (response.retCode == URLREQUEST_SUCCEED && response.detailRetCode == kOpenSDKErrorSuccess) {
            
            NSMutableString *message = [[NSMutableString alloc] init];
            for (id key in response.jsonResponse) {
                [message appendFormat:@"\n%@ -- %@" ,key, response.jsonResponse[key]];
            }
            NSLog(@"message = %@\n" ,message);
            [TencentApiManager showAlertView:@"用户基本信息" message:message];
        }
    }
}

- (void)didGetListAlbumResponseFromNotification:(NSNotification *)notify {
    
    if (notify) {
        
        APIResponse *response = notify.userInfo[kResponse];
        
        if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode) {
            [TencentApiManager showAlertView:@"获取相册列表" message:[response jsonResponse][@"msg"]];
        }
        
    }
}

- (void)closeWnd:(NSNotification *)notify {
    
}

#pragma mark - dealloc 释放
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
