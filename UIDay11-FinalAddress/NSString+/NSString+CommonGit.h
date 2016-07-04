//
//  NSString+CommonGit.h
//  UIDay10-AddressBookSecond
//
//  Created by LML on 15/11/27.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (CommonGit)

/**
 *  获取拼音首字母
 *
 *  @param aString 传入的汉字字符串
 *
 *  @return 汉字首字拼音的首字母大写
 */
+ (NSString *)firstCharactor:(NSString *)aString;

/**
 *  计算label的高度
 *
 *  @param text  要适应label的文本内容
 *  @param font  当前文本的字体大小
 *  @param width label固定的宽度
 *
 *  @return 自适应之后label的高度
 */
+ (CGFloat)heightOfSelfSuit:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

@end
