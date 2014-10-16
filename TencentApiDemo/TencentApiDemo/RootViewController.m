//
//  RootViewController.m
//  TencentApiDemo
//
//  Created by wadexiong on 14-10-15.
//  Copyright (c) 2014年 wadexiong. All rights reserved.
//

#import "RootViewController.h"
#import "TencentApiManager.h"
#import "ShareToQQViewController.h"
#import "QZoneApiViewController.h"

@interface RootViewController () {
    NSArray *_permissons;
}

@end

@implementation RootViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginQQClick:(id)sender {
//    _permissons = [NSArray arrayWithObjects:
//                            kOPEN_PERMISSION_GET_USER_INFO,
//                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
//                            kOPEN_PERMISSION_ADD_ALBUM,
//                            kOPEN_PERMISSION_ADD_IDOL,
//                            kOPEN_PERMISSION_ADD_ONE_BLOG,
//                            kOPEN_PERMISSION_ADD_PIC_T,
//                            kOPEN_PERMISSION_ADD_SHARE,
//                            kOPEN_PERMISSION_ADD_TOPIC,
//                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
//                            kOPEN_PERMISSION_DEL_IDOL,
//                            kOPEN_PERMISSION_DEL_T,
//                            kOPEN_PERMISSION_GET_FANSLIST,
//                            kOPEN_PERMISSION_GET_IDOLLIST,
//                            kOPEN_PERMISSION_GET_INFO,
//                            kOPEN_PERMISSION_GET_OTHER_INFO,
//                            kOPEN_PERMISSION_GET_REPOST_LIST,
//                            kOPEN_PERMISSION_LIST_ALBUM,
//                            kOPEN_PERMISSION_UPLOAD_PIC,
//                            kOPEN_PERMISSION_GET_VIP_INFO,
//                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
//                            kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
//                            kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
//                            nil];
    _permissons = [NSArray arrayWithObjects:@"all", nil];

    [[[TencentApiManager getInstance] oauth] authorize:_permissons inSafari:NO];
}

- (IBAction)shareToQQClick:(id)sender {
    ShareToQQViewController *vc = [[ShareToQQViewController alloc] init];
    vc.title = @"分享至QQ好友";
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)shareToQZoneClick:(id)sender {
    QZoneApiViewController *vc = [[QZoneApiViewController alloc] init];
    vc.title = @"QQ空间API";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
