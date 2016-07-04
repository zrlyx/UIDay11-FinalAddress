//
//  GirlTableViewCell.m
//  UIDay11-FinalAddress
//
//  Created by LML on 15/11/28.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import "GirlTableViewCell.h"
#import "Contact.h"

@implementation GirlTableViewCell

- (void)dealloc
{
    [_picture release];
    [_name release];
    [_phoneNumber release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.picture = [[UIImageView alloc] init];
        [self.contentView addSubview:self.picture];
        [_picture release];
        
        self.name = [[UILabel alloc] init];
        [self.contentView addSubview:self.name];
        [_name release];
        
        self.phoneNumber = [[UILabel alloc] init];
        [self.contentView addSubview:self.phoneNumber];
        [_phoneNumber release];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.picture.frame = CGRectMake(225, 0, 80, self.contentView.frame.size.height);
    self.name.frame = CGRectMake(10, 30, 200, 20);
    self.phoneNumber.frame = CGRectMake(10, 50, 200, 30);
    
}

- (void)setContact:(Contact *)contact {
    
    if (contact != _contact) {
        [_contact release];
        _contact = [contact retain];
    }
    
    self.picture.image = [UIImage imageNamed:_contact.picture];
    self.name.text = _contact.name;
    self.phoneNumber.text = _contact.phoneNumber;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
