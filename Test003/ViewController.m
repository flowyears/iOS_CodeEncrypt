//
//  ViewController.m
//  Test003
//
//  Created by 沈佳雄 on 2018/8/2.
//  Copyright © 2018年 沈佳雄. All rights reserved.
//

#import "ViewController.h"
#import "AngelCheckTool.h"


//#define dcstr(intChar, outChar)\
//{\
//char* origin_string = intChar;\
//while(*intChar) {\
//*intChar ^= 0xAA;\
//intChar++;\
//}\
//outChar = origin_string;\
//}
//
////字符串混淆加密 和 解密的宏开关
#define ggh_confusion
//#ifdef ggh_confusion
//#define confusion_NSSTRING(string)\
//{\
//char *temp = dcstr([string UTF8String]);\
//return [NSString stringWithUTF8String:temp];\
//}
//
//#define confusion_CSTRING(string) dcstr(string)
//#else
//#define confusion_NSSTRING(string) @string
//#define confusion_CSTRING(string) string
//#endif







//#define dcstr(string)\
//\
//char* decryptConstString(string)\
//{\
//char* origin_string = string;\
//while(*string) {\
//*string ^= 0xAA;\
//string++;\
//}\
//return origin_string;\
//}
//
////字符串混淆加密 和 解密的宏开关
#define ggh_confusion
//#ifdef ggh_confusion
//#define confusion_NSSTRING(string)\
//\
//NSString* confusion_to_nsstring(string)\
//{\
//    char *temp = dcstr(string);\
//    return [NSString stringWithUTF8String:temp];\
//}
//
//#define confusion_CSTRING(string) dcstr(string)
//#else
//#define confusion_NSSTRING(string) @string
//#define confusion_CSTRING(string) string
//#endif


@interface ViewController ()
@property(nonatomic,strong)UIVisualEffectView *effectView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *lb = [[UILabel alloc] init];
    lb.text = @"hello world";
    lb.frame = CGRectMake(50, 100, 100, 100);
    lb.textColor = [UIColor blackColor];
    [self.view addSubview:lb];
    
    //[self.view addSubview:self.effectView];
}

-(UIVisualEffectView *)effectView
{
    if (!_effectView)
    {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = self.view.bounds;
    }
    return _effectView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sample
{
    NSLog(@"sample");
}
-(void)seg1:(NSString *)string seg2:(NSUInteger)num
{
    NSString *retStr = confusion_NSSTRING(((char []) {206, 206, 206, 206, 0}));
    NSLog(@"%@", retStr);
}
    
    
- (void)inserta:(NSString *)a toB:(NSString *)b lalla:(NSArray *)arr
    {
        NSString *retStr = confusion_NSSTRING(((char []) {195, 196, 217, 207, 216, 222, 203, 144, 222, 197, 232, 134, 198, 203, 198, 198, 203, 138, 134, 201, 203, 196, 138, 211, 197, 223, 138, 217, 207, 207, 138, 199, 207, 149, 0}));
        NSLog(@"%@", retStr);

    }

@end
