//
//  FourLines.h
//  Presistence
//
//  Created by 张光发 on 15/11/14.
//  Copyright © 2015年 张光发. All rights reserved.
//

#import <Foundation/Foundation.h>

//如果所有的属性都是标量，或者这个类遵守nscoding协议就能进行归档
//另外最好遵守nscopying协议，这可以灵活的使用数据模型
@interface FourLines : NSObject<NSCopying,NSCoding>

@property(copy,nonatomic) NSArray* lines;
@end
