//
//  ZQProvince.h
//  ZQPickerView
//
//  Created by 周周旗 on 2018/11/16.
//  Copyright © 2018 ZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZQProvince : NSObject

@property (nonatomic, strong) NSArray *sub;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ProvinceWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END

