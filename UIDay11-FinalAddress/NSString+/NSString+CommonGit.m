//
//  NSString+CommonGit.m
//  UIDay10-AddressBookSecond
//
//  Created by LML on 15/11/27.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import "NSString+CommonGit.h"

@implementation NSString (CommonGit)

#pragma mark 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)firstCharactor:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

#pragma mark 计算label的自适应高度
+ (CGFloat)heightOfSelfSuit:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    
    //第一步: 设置文本显示的范围
    //如果计算label的自适应高度, 那么宽度需要固定, 高度需要尽量设置大值;  (计算的方向)
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    //第二步: 设置要显示的文本样式 计算高度只有大小影响
    //key是系统设置好的用来描述样式的值
    NSDictionary *style = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    
    //第三步: 根据文本内容和文本样式计算label的frame
    /**
     *  参数说明: 1.文本的显示范围;
     *           2.文本显示规则 : 根据字体计算
     *           3.文本的样式 (通常只包括字体大小)
     *           4.通常nil
     */
    CGRect result = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:style context:nil];
    
    //返回自适应之后高度
    return result.size.height;
}

@end
