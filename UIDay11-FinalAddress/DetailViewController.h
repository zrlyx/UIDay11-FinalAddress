//
//  DetailViewController.h
//  UIDay9-AddressBook
//
//  Created by LML on 15/11/25.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Contact;

@protocol DetailViewControllerDelegate <NSObject>

- (void)updateStudentDetail:(Contact * _Nonnull)contant index:(NSIndexPath * _Nonnull)indexPath;

@end

@interface DetailViewController : UIViewController

@property(nonatomic, retain)Contact * _Nonnull student;
/**
 *  得到学生位置,用于传回
 */
@property(nonatomic, retain)NSIndexPath * _Nonnull index;

@property(nonatomic, assign)_Nonnull id<DetailViewControllerDelegate>delegate;

@end
