//
//  ViewController.m
//  Presistence
//
//  Created by 张光发 on 15/11/11.
//  Copyright © 2015年 张光发. All rights reserved.
//

#import "ViewController.h"

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
    //获取data.plist文件的完整路径
    return [documentDiectory stringByAppendingPathExtension:@"data.plist"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取完整路径
    NSString *filePath=[self dataFailePath];
    //确保文件存在
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        //把文件中的内容加载到nsarray中
        NSArray *array=[[NSArray alloc] initWithContentsOfFile:filePath];
        //把nsarray中的内容恢复到输入框中
        for (int i=0; i<4; i++) {
            UITextField *theField=self.lineFields[i];
            theField.text=array[i];
            NSLog(@"%@",array[i]);
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
    //把输入内容收集到nsarray
    NSArray *array=[self.lineFields valueForKey:@"text"];
    //把nsarray的内容写到文件中
    //atomically设置为yes可以把内容先写到副本中，防止因为程序崩溃造成原来的文件损坏
    [array writeToFile:filePath atomically:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
