//
//  DistInfoViewController.m
//  MobilePartySchool
//
//  Created by linxiaodong on 15/10/19.
//  Copyright © 2015年 com.nd.hy. All rights reserved.
//

#import "DistInfoViewController.h"

@interface DistDataEntity : NSObject
@property (nonatomic ,strong) NSString *    text;
@property (nonatomic ,strong) NSString *    Id;
@end
@implementation DistDataEntity
@synthesize text,Id;
@end

@interface DistInfoViewController ()
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *distArray;
@end

@implementation DistInfoViewController

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
    _distArray = [self getDistData];
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *mytableView = nil;
    if (self.distArray.count * 44 >= (self.view.frame.size.height-44)) {
        mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    }else{
        mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.distArray.count * 44)];
    }
    mytableView.delegate = self;
    mytableView.dataSource = self;
    [self.view addSubview:mytableView];
    self.tableView = mytableView;
    
    // Do any additional setup after loading the view.
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


#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _distArray.count;
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    DistDataEntity *entity = [self.distArray objectAtIndex:indexPath.row];
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 44)];
    textLab.backgroundColor = [UIColor clearColor];
    textLab.text = entity.text;
    textLab.font = [UIFont systemFontOfSize:17];
    [cell addSubview:textLab];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DistDataEntity *entity = [self.distArray objectAtIndex:indexPath.row];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.provName,@"prov",self.cityName,@"city",entity.text,@"dist",@(self.ProjectFiledType),@"type",nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:USER_INFO_CITY_NOTIFY object:nil userInfo:dic];
}


- (NSMutableArray *)getDistData
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary *jsonDic = [NSDictionary getCityJson];
    NSArray *dist = [jsonDic objectForKey:@"dist"];
    for (NSDictionary *distDic in dist) {
        DistDataEntity *dataEntity = [[DistDataEntity alloc]init];
        dataEntity.Id = [distDic objectForKey:@"Id"];
        dataEntity.text = [distDic objectForKey:@"text"];
        if (dataEntity.Id.integerValue/100 == self.cityId.integerValue/100) {
            [array addObject:dataEntity];
        }
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
