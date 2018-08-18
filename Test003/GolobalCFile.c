//
//  GolobalCFile.c
//  Test003
//
//  Created by 沈佳雄 on 2018/8/18.
//  Copyright © 2018 沈佳雄. All rights reserved.
//

#include "GolobalCFile.h"


/*
 *  字符串混淆解密函数，将char[] 形式字符数组和 aa异或运算揭秘
 *  如果没有经过混淆，请关闭宏开关
 */
char* decryptConstString(char* string)
{
    char* origin_string = string;
    while(*string) {
        *string ^= 0xAA;
        string++;
    }
    return origin_string;
}
