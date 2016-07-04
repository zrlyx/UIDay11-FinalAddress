//
//  BoyTableViewCell.h
//  UIDay11-FinalAddress
//
//  Created by LML on 15/11/28.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@interface BoyTableViewCell : UITableViewCell

@property(nonatomic, retain)UIImageView *picture;
@property(nonatomic, retain)UILabel *name;
@property(nonatomic, retain)UILabel *phoneNumber;
@property(nonatomic, retain)Contact *contact;

@end
