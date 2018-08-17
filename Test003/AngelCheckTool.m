//
//  AngelCheckTool.m
//  Test003
//
//  Created by 沈佳雄 on 2018/8/3.
//  Copyright © 2018年 沈佳雄. All rights reserved.
//

#import "AngelCheckTool.h"
#import <UIKit/UIKit.h>
#import <sys/stat.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>


#define VALUE_HELLO_ANGEL @"dfsdfdsfsdfsdfsdf"
#define KEY_HELLO_ANGEL @"key_hello_Angel"

#define VALUE_IPA_CHANGED @"sdfldklfkdlsfkld"
#define KEY_IPA_CHANGED @"HELLOMMMM"

@implementation AngelCheckTool


+ (void)check001
{
    [[self class] func1];
    
    [[self class] func2];
    [[self class] func3];
  
    func4();
    func5();
    func6();
    func7();
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *value = [userDefault valueForKey:KEY_HELLO_ANGEL];
    if ([value isEqualToString:VALUE_HELLO_ANGEL])
    {
        [[self class] showTips:@"您的设备已越狱" msg:nil okTitle:@"知道了"];
    }
}

//检查程序是否被篡改
+ (void)check002
{
    [[self class] fun010];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];

    NSString *value = [userDefault valueForKey:KEY_IPA_CHANGED];
    if ([value isEqualToString:VALUE_IPA_CHANGED])
    {
        [[self class] showTips:@"您的程序已被篡改" msg:@"请从app store下载本应用" okTitle:@"知道了"];
    }
}

/**
 使用NSFileManager判断设备是否安装了如下越狱常用工具：
 /Applications/Cydia.app
 /Library/MobileSubstrate/MobileSubstrate.dylib
 /bin/bash
 /usr/sbin/sshd
 /etc/apt
 */
+(void)func1
{
    NSArray *arr = @[@"/Applications/Cydia.app",
                     @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                     @"/usr/sbin/sshd",
                     @"/etc/apt"];
    [arr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:obj]){
            [[self class] helloAngel];
            *stop = YES;
        }
    }];
}

/**
 尝试打开cydia应用注册的URL scheme
 */
+ (void)func2
{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]])
    {
        [[self class] helloAngel];
    }
}


/**
 读取下应用列表，看看有无权限获取
 */
+ (void)func3
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"])
    {
        [[self class] helloAngel];
    }
}



/**
 使用stat系列函数检测Cydia等工具
 */
void func4(void)
{
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info))
    {
        helloAngel();
    }
}



/**
 攻击者可能会利用 Fishhook原理 hook了stat。
 那么，你可以看看stat是不是出自系统库，有没有被攻击者换掉
 */
void func5(void)
{
    int ret ;
    Dl_info dylib_info;
    int    (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        //NSLog(@"lib :%s", dylib_info.dli_fname);
    }
    else
    {
        helloAngel();
    }
}



/**
 检索一下自己的应用程序是否被链接了异常动态库。
 
 列出所有已链接的动态库：
 会包含越狱机的输出结果会包含字符串： Library/MobileSubstrate/MobileSubstrate.dylib
 */
void func6(void)
{
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
        NSString *name = [[NSString alloc]initWithUTF8String:_dyld_get_image_name(i)];
        if ([name containsString:@"Library/MobileSubstrate/MobileSubstrate.dylib"])
        {
            helloAngel();
            break;
        }
    }
}



/**
 检测当前程序运行的环境变量
 返回结果是null，越狱设备就各有各的精彩了，尤其是老一点的iOS版本越狱环境
 */
void func7(void)
{
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    
    if (env != NULL)
    {
        helloAngel();
    }

}

void helloAngel(void)
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:VALUE_HELLO_ANGEL forKey:KEY_HELLO_ANGEL];
    [userDefault synchronize];
}

+ (void)helloAngel
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:VALUE_HELLO_ANGEL forKey:KEY_HELLO_ANGEL];
    [userDefault synchronize];
}

+ (void)fun010
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    if ([info objectForKey:@"SignerIdentity"] != nil)
    {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:VALUE_IPA_CHANGED forKey:KEY_IPA_CHANGED];
        [userDefault synchronize];
    }
}

+ (void)showTips:(NSString *)tips msg:(NSString *)msg okTitle:(NSString *)okTitle
{
    UIWindow  *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    alertWindow.rootViewController = [[UIViewController alloc] init];
    
    alertWindow.windowLevel = UIWindowLevelAlert + 1;
    
    [alertWindow makeKeyAndVisible];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:tips
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:okTitle
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alertController addAction:actionOK];
    [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
