//
//  AreaInfoViewController.m
//  MobilePartySchool
//
//  Created by linxiaodong on 15/10/19.
//  Copyright © 2015年 com.nd.hy. All rights reserved.
//

#import "ProvInfoViewController.h"


@interface ProvDataEntity : NSObject
@property (nonatomic ,strong) NSString *    text;
@property (nonatomic ,strong) NSString *    Id;
@end

@implementation ProvDataEntity
@synthesize text,Id;
@end

@interface ProvInfoViewController ()
{
   
}
@property (nonatomic ,strong) NSArray *provArray;
@property (retain, nonatomic) UITableView *tableView;
@end

@implementation ProvInfoViewController

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
    self.provArray = [self getProviceData];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *mytableView = nil;
    if (self.provArray.count * 44 >= (self.view.frame.size.height-44)) {
        mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    }else{
        mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.provArray.count * 44)];
    }
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [self.view addSubview:mytableView];
    self.tableView = mytableView;
//    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 消息中心，统一处理页面上所有元素的时间
- (void)cancleTap
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.provArray.count;
}
- (CGFloat)tableView:(UITableView *)mytableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc]init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    ProvDataEntity *entity = [self.provArray objectAtIndex:indexPath.row];
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 44)];
    textLab.backgroundColor = [UIColor clearColor];
    textLab.text = entity.text;
    textLab.font = [UIFont systemFontOfSize:17];
    [cell addSubview:textLab];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProvDataEntity *entity = [self.provArray objectAtIndex:indexPath.row];
    CityInfoViewController *infoVC = [[CityInfoViewController alloc]init];
    infoVC.ProjectFiledType = self.ProjectFiledType;
    infoVC.provId = entity.Id;
    infoVC.provName = entity.text;
    [self presentViewController:infoVC animated:YES completion:NULL];
}



- (NSMutableArray *)getProviceData
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary *jsonDic = [NSDictionary getCityJson];
    NSArray *prov = [jsonDic objectForKey:@"prov"];
    for (NSDictionary *provDic in prov) {
        ProvDataEntity *dataEntity = [[ProvDataEntity alloc]init];
        dataEntity.Id = [provDic objectForKey:@"Id"];
        dataEntity.text = [provDic objectForKey:@"text"];
        [array addObject:dataEntity];
    }
    return array;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
