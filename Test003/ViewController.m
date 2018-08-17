//
//  ViewController.m
//  Test003
//
//  Created by 沈佳雄 on 2018/8/2.
//  Copyright © 2018年 沈佳雄. All rights reserved.
//

#import "ViewController.h"
#import "AngelCheckTool.h"

#define STRING_OBFUSCATE

static char* decryptConstString(char* string) __attribute__((always_inline));

#define NSSTRING(string) [NSString stringWithUTF8String:decryptConstString(string)]
#define CSTRING(string) decryptConstString(string)

static char* decryptConstString(char* string)
{
    char* origin_string = string;
    while(*string) {
        *string ^= 0xAA;
        string++;
    }
    return origin_string;
}

#ifndef STRING_OBFUSCATE

#define NSSTRING(string) @string
#define CSTRING(string) string

#endif
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
    NSLog(@"%@", NSSTRING("seg1:seg2,can you see me?"));
}
    
    
- (void)inserta:(NSString *)a toB:(NSString *)b lalla:(NSArray *)arr
    {
        NSLog(@"%@",NSSTRING("inserta:toB,lalla ,can you see me?"));

    }

@end
