//
//  ViewController.m
//  Presistence
//
//  Created by 张光发 on 15/11/11.
//  Copyright © 2015年 张光发. All rights reserved.
//

#import "ViewController.h"
#import "FourLines.h"

static NSString* const kRootKey=@"kRootKey";

@interface ViewController ()
@property(strong,nonatomic) IBOutletCollection(UITextField) NSArray *lineFields;
@end

@implementation ViewController

//获取data.plist文件完整路径
-(NSString *)dataFailePath
{
    //获取Documents文件的路径
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDiectory=[path objectAtIndex:0];
    //获取data.archive文件的完整路径
    return [documentDiectory stringByAppendingPathExtension:@"data.archive"];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取完整路径
    NSString *filePath=[self dataFailePath];
    //确保文件存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //把文件中的内容加载到nsdata中
        NSData *data=[[NSMutableData alloc] initWithContentsOfFile:filePath];
        //创建一个NSKeyedUnarchiver对象用来解码数据
        NSKeyedUnarchiver *unarchiver=[[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        //把解码的数据中kRootKey对应的值恢复为FourLines
        FourLines *fourLines=[unarchiver decodeObjectForKey:kRootKey];
        //结束解码操作
        [unarchiver finishDecoding];
        
        for (int i = 0; i<4; i++) {
            UITextField *theFields=self.lineFields[i];
            theFields.text=fourLines.lines[i];
        }
    }
    
    //订阅通知
    UIApplication *app=[UIApplication sharedApplication];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

//收到通知的回调方法
-(void)applicationWillResignActive:(NSNotification *)notification
{
    NSLog(@"接收到通知");
    //获取文件路径
    NSString *filePath=[self dataFailePath];
    
    FourLines *fourines=[[FourLines alloc] init];
    fourines.lines=[self.lineFields valueForKey:@"text"];
    NSMutableData *data=[[NSMutableData alloc] init];
    //创建NSKeyedArchiver对象用来编码数据
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //把fourines数据编码赋值给kRootKey对应的值
    [archiver encodeObject:fourines forKey:kRootKey];
    //结束编码操作
    [archiver finishEncoding];
    //把编码后的内容写入文件
    [data writeToFile:filePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
