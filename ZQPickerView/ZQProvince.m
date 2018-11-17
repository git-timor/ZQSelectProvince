//
//  ZQProvince.m
//  ZQPickerView
//
//  Created by 周周旗 on 2018/11/16.
//  Copyright © 2018 ZQ. All rights reserved.
//

#import "ZQProvince.h"


@implementation ZQProvince

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)ProvinceWithDict:(NSDictionary *)dict{
    
    return [[self alloc] initWithDict:dict];
}
@end
