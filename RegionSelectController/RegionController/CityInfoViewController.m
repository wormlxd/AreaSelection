//
//  CityInfoViewController.m
//  MobilePartySchool
//
//  Created by linxiaodong on 15/10/19.
//  Copyright © 2015年 com.nd.hy. All rights reserved.
//

#import "CityInfoViewController.h"
#import "DistInfoViewController.h"
#import "NSDictionary+HYCity.h"

@interface CityDataEntity : NSObject
@property (nonatomic ,strong) NSString *    text;
@property (nonatomic ,strong) NSString *    Id;
@end
@implementation CityDataEntity
@synthesize text,Id;
@end


@interface CityInfoViewController ()
@property (nonatomic ,strong)NSArray *cityArray;
@property (retain, nonatomic) UITableView *tableView;
@end

@implementation CityInfoViewController

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
    _cityArray = [self getCityData];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *mytableView = nil;
    if (self.cityArray.count * 44 >= (self.view.frame.size.height-44)) {
        mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height-44)];
    }else{
        mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.cityArray.count * 44)];
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
    
}


#pragma mark TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cityArray.count;
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
    
    CityDataEntity *entity = [self.cityArray objectAtIndex:indexPath.row];
    UILabel *textLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 44)];
    textLab.backgroundColor = [UIColor clearColor];
    textLab.text = entity.text;
    textLab.font = [UIFont systemFontOfSize:17];
    [cell addSubview:textLab];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityDataEntity *entity = [self.cityArray objectAtIndex:indexPath.row];
    DistInfoViewController *infoVC = [[DistInfoViewController alloc]init];
    infoVC.ProjectFiledType = self.ProjectFiledType;
    infoVC.cityId = entity.Id;
    infoVC.cityName = entity.text;
    infoVC.provName = self.provName;
    [self presentViewController:infoVC animated:YES completion:NULL];
}


- (NSMutableArray *)getCityData
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSDictionary *jsonDic = [NSDictionary getCityJson];
    NSArray *city = [jsonDic objectForKey:@"city"];
    for (NSDictionary *cityDic in city) {
        CityDataEntity *dataEntity = [[CityDataEntity alloc]init];
        dataEntity.Id = [cityDic objectForKey:@"Id"];
        dataEntity.text = [cityDic objectForKey:@"text"];
        if (dataEntity.Id.integerValue/10000 == self.provId.integerValue/10000) {
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
