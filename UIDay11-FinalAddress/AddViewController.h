//
//  AddViewController.h
//  UIDay10-AddressBookSecond
//
//  Created by LML on 15/11/26.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@protocol AddViewControllerDelegate <NSObject>

- (void)addTableViewByContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController

@property(nonatomic, retain)Contact *student;
@property(nonatomic, assign)id <AddViewControllerDelegate> delegate;

@end
