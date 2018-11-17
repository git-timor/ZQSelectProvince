//
//  ViewController.m
//  ZQPickerView
//
//  Created by 周周旗 on 2018/11/16.
//  Copyright © 2018 ZQ. All rights reserved.
//

#import "ViewController.h"
#import "ZQProvince.h"
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) ZQProvince *selProvince;
@property (nonatomic, strong) NSArray *provinces;
@property (weak, nonatomic) IBOutlet UILabel *labProvince;
@property (weak, nonatomic) IBOutlet UILabel *labCity;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - 懒加载
- (NSArray *)provinces{
    if (!_provinces) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"address.plist" ofType:nil]];
        NSArray *dictArr = [dic objectForKey:@"address"];
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dictArr.count];
        for (NSDictionary *dict in dictArr) {
            ZQProvince *pro = [ZQProvince ProvinceWithDict:dict];
            [arrM addObject:pro];
        }
        _provinces = arrM;
    }
    return _provinces;
}

#pragma mark -- 协议

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

//程序运行先进入此方法，所以可以在此方法中保存选中的省数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //省模型组
    if (component == 0) {
        return self.provinces.count;
        
    }else{
        /*对应的市模型
         1.先根据获取0组中是哪个省确认选中的行号
         2.再根据省获取市的数据
         */
        NSInteger selProIdx = [pickerView selectedRowInComponent:0];
        //从集合中获取数据
        ZQProvince *selPro = self.provinces[selProIdx];
        //保存选中省的数据
        self.selProvince = selPro;
        //2.根据省的数据去获取市的行数。
        return self.selProvince.sub.count;
    }
}
#pragma mark -- 代理

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        ZQProvince *pro = self.provinces[row];
        return pro.name;
    }else{
        return [self.selProvince.sub[row] objectForKey:@"name"];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    //如果点击的是第 0 组 省 则需刷新城市的数据
    if (component == 0) {
        [pickerView reloadComponent:1];
        //每次刷新第 0 组 都去刷新第 1 组并显示第 0 行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    /* 记录选取数据 以做展示
       1.获取数据
       2.获取选中的行
       3.根据行记录
    */
    //1.从集合中获取数据
    //2.
    NSInteger selProIdx = [pickerView selectedRowInComponent:0];
    NSInteger selCityIdx = [pickerView selectedRowInComponent:1];
    ZQProvince *selPro = self.provinces[selProIdx];
    NSString *selCity = [self.selProvince.sub[selCityIdx] objectForKey:@"name"];
      //3.
    self.labProvince.text = selPro.name;
    self.labCity.text = selCity;
}
@end
