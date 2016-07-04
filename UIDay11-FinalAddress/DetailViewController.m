//
//  DetailViewController.m
//  UIDay9-AddressBook
//
//  Created by LML on 15/11/25.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import "DetailViewController.h"
#import "Contact.h"

@interface DetailViewController () <UITextFieldDelegate>

@end

@implementation DetailViewController

- (void)dealloc
{
    [_index release];
    [_student release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.student.name;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"< 通讯录" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 150, 200)];
    imageView.image = [UIImage imageNamed:self.student.picture];
    [self.view addSubview:imageView];
    [imageView release];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(170, 10, 100, 40)];
    name.tag = 1;
    name.delegate = self;
    name.borderStyle = UITextBorderStyleRoundedRect;
    name.text = self.student.name;
    [self.view addSubview:name];
    [name release];
    
    UITextField *sex = [[UITextField alloc] initWithFrame:CGRectMake(170, 80, 50, 40)];
    sex.tag = 2;
    sex.delegate = self;
    sex.borderStyle = UITextBorderStyleRoundedRect;
    sex.text = self.student.gender;
    [self.view addSubview:sex];
    [sex release];
    
    UITextField *age = [[UITextField alloc] initWithFrame:CGRectMake(230, 80, 50, 40)];
    age.tag = 3;
    age.delegate = self;
    age.borderStyle = UITextBorderStyleRoundedRect;
    age.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    age.text = self.student.age;
    [self.view addSubview:age];
    [age release];
    
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(170, 140, 140, 40)];
    phone.tag = 4;
    phone.delegate = self;
    phone.borderStyle = UITextBorderStyleRoundedRect;
    phone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phone.text = self.student.phoneNumber;
    [self.view addSubview:phone];
    [phone release];
    
    UITextField *hobby = [[UITextField alloc] initWithFrame:CGRectMake(10, 220, self.view.frame.size.width - 20, 80)];
    hobby.tag = 5;
    hobby.delegate = self;
    hobby.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    hobby.borderStyle = UITextBorderStyleRoundedRect;
    hobby.text = self.student.hobby;
    [self.view addSubview:hobby];
    [hobby release];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    switch (textField.tag) {
        case 1:
            self.student.name = textField.text;
            break;
        case 2:
            self.student.gender = textField.text;
            break;
        case 3:
            self.student.age = textField.text;
            break;
        case 4:
            self.student.phoneNumber = textField.text;
            break;
        case 5:
            self.student.hobby = textField.text;
            break;
    }
}

- (void)backAction {
    
    [self.delegate updateStudentDetail:self.student index:self.index];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
