//
//  QZoneApiViewController.m
//  TencentApiDemo
//
//  Created by wadexiong on 14-10-15.
//  Copyright (c) 2014年 wadexiong. All rights reserved.
//

#import "QZoneApiViewController.h"
#import "TencentApiManager.h"
#import "TencenApiDef.h"

@interface QZoneApiViewController () <UIImagePickerControllerDelegate>

@end

@implementation QZoneApiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        //XZH 初始化注册监听者
        [[NSNotificationCenter defaultCenter] addObserver:[TencentApiManager getInstance] selector:@selector(closeWnd:) name:kCloseWnd object:[TencentApiManager getInstance]];
        [[NSNotificationCenter defaultCenter] addObserver:[TencentApiManager getInstance] selector:@selector(didGetResponseFromNotification:) name:kGetUserInfoResponse object:[TencentApiManager getInstance]];
        [[NSNotificationCenter defaultCenter] addObserver:[TencentApiManager getInstance] selector:@selector(didGetResponseFromNotification:) name:kUploadPicResponse object:[TencentApiManager getInstance]];
        [[NSNotificationCenter defaultCenter] addObserver:[TencentApiManager getInstance] selector:@selector(didGetListAlbumResponseFromNotification:) name:kGetListAlbumResponse object:[TencentApiManager getInstance]];
        [[NSNotificationCenter defaultCenter] addObserver:[TencentApiManager getInstance] selector:@selector(didGetResponseFromNotification:) name:kAddTopicResponse object:[TencentApiManager getInstance]];
        [[NSNotificationCenter defaultCenter] addObserver:[TencentApiManager getInstance] selector:@selector(didGetResponseFromNotification:) name:kCheckPageFansResponse object:[TencentApiManager getInstance]];
        [[NSNotificationCenter defaultCenter] addObserver:[TencentApiManager getInstance] selector:@selector(didGetResponseFromNotification:) name:kAddOneBlogResponse object:[TencentApiManager getInstance]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(pop:)];
}

- (void)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getUserInfo:(id)sender {
    [TencentApiManager getUserInfo];
}

- (IBAction)uploadPicture:(id)sender {
    [self pickerImage];
}

- (IBAction)sendStory:(id)sender {
}

- (IBAction)getPhotoAlbum:(id)sender {
    [TencentApiManager getListalbum];
}

- (IBAction)createPhotoAlbum:(id)sender {
}

- (IBAction)settingUserImage:(id)sender {
}

#pragma mark - pickerImage
- (void)pickerImage {
    
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Imag Picker Controller Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSLog(@"info = %@\n" ,info);
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Other
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:[TencentApiManager getInstance]];
}
@end
