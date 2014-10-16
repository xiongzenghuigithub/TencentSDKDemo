//
//  ShareToQQViewController.m
//  TencentApiDemo
//
//  Created by wadexiong on 14-10-15.
//  Copyright (c) 2014年 wadexiong. All rights reserved.
//

#import "ShareToQQViewController.h"
#import "TencentApiManager.h"


@interface ShareToQQViewController ()

@end

@implementation ShareToQQViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
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

- (IBAction)shareTxtClick:(id)sender {
    [TencentApiManager shareTextMsg:@"分带有链接的文本信息"];
}

- (IBAction)sharePicClick:(id)sender {
    [TencentApiManager sharePicMsg:@"sharePic"];
}

- (IBAction)shareNewsClick:(id)sender {
    [TencentApiManager shareNews];
}

- (IBAction)shareAudioClick:(id)sender {
    [TencentApiManager shareAudio];
}

- (IBAction)shareVedioClick:(id)sender {
    [TencentApiManager shareVideo];
}
@end
