//
//  ViewController.m
//  RegionSelectController
//
//  Created by linxiaodong on 15/11/6.
//  Copyright © 2015年 linxiaodong. All rights reserved.
//

#import "ViewController.h"
#import "ProvInfoViewController.h"

@interface ViewController ()
{
    IBOutlet UIButton *_regionSelectBtn;
    IBOutlet UILabel *_textLabel;
}
@end

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setArea:) name:USER_INFO_CITY_NOTIFY object:nil];
}
-(void)setArea:(NSNotification *)notify
{
    [self.presentedViewController.presentedViewController.presentedViewController dismissViewControllerAnimated:NO completion:^{
        [self.presentedViewController.presentedViewController dismissViewControllerAnimated:NO completion:^{
            [self.presentedViewController dismissViewControllerAnimated:NO completion:NULL];
        }];
    }];
    
    NSDictionary *dic = [notify userInfo];
    NSString * distants = [NSString stringWithFormat:@"%@ %@ %@",[dic objectForKey:@"prov"],[dic objectForKey:@"city"],[dic objectForKey:@"dist"]];
    _textLabel.text = distants;
}

-(IBAction)selectBtnPressed:(id)sender

{
    ProvInfoViewController *proInfoVc = [[ProvInfoViewController alloc]init];
    [self presentViewController:proInfoVc animated:YES completion:NULL];
}



@end
