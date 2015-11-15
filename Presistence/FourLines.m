//
//  FourLines.m
//  Presistence
//
//  Created by 张光发 on 15/11/14.
//  Copyright © 2015年 张光发. All rights reserved.
//

#import "FourLines.h"
//存储时的key
static NSString* const kLinesKey = @"kLinesKey";

@implementation FourLines

#pragma mark- coding
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        //解码并获取
        self.lines=[aDecoder decodeObjectForKey:kLinesKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //编码
    [aCoder encodeObject:self.lines forKey:kLinesKey];
}

#pragma mark - copying
-(id)copyWithZone:(NSZone *)zone
{
    //赋值一份FourLines
    FourLines *copy=[[[self class] allocWithZone:zone] init];
    NSMutableArray *lineCopy=[NSMutableArray array];
    for (id line in self.lines) {
        [lineCopy addObject:[line copyWithZone:zone]];
    }
    //给副本赋值
    copy.lines=lineCopy;
    return copy;
}

@end
