//
//  Student.m
//  UIDay9-AddressBook
//
//  Created by LML on 15/11/25.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import "Contact.h"

@implementation Contact

- (void)dealloc
{
    [_name release];
    [_gender release];
    [_age release];
    [_phoneNumber release];
    [_hobby release];
    [_picture release];
    [super dealloc];
}

@end
