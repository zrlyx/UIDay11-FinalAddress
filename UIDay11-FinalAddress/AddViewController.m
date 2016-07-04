//
//  AddViewController.m
//  UIDay10-AddressBookSecond
//
//  Created by LML on 15/11/26.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import "AddViewController.h"
#import "Contact.h"
#import "PickerViewController.h"

@interface AddViewController () <UITextFieldDelegate>

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"添加联系人";
    
    self.student = [[Contact alloc] init];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"储存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = right;
    [right release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 150, 200)];
    imageView.tag = 11;
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"miku2.jpg"];
    [self.view addSubview:imageView];
    [imageView release];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(170, 10, 100, 40)];
    name.tag = 1;
    name.placeholder = @"姓名";
    name.delegate = self;
    name.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:name];
    [name release];
    
    UITextField *sex = [[UITextField alloc] initWithFrame:CGRectMake(170, 80, 50, 40)];
    sex.tag = 2;
    sex.delegate = self;
    sex.placeholder = @"性别";
    sex.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:sex];
    [sex release];
    
    UITextField *age = [[UITextField alloc] initWithFrame:CGRectMake(230, 80, 50, 40)];
    age.tag = 3;
    age.delegate = self;
    age.placeholder = @"年龄";
    age.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    age.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:age];
    [age release];
    
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(170, 140, 140, 40)];
    phone.tag = 4;
    phone.delegate = self;
    phone.placeholder = @"电话号";
    phone.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phone.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:phone];
    [phone release];
    
    UITextField *hobby = [[UITextField alloc] initWithFrame:CGRectMake(10, 220, self.view.frame.size.width - 20, 80)];
    hobby.tag = 5;
    hobby.delegate = self;
    hobby.placeholder = @"爱好";
    hobby.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    hobby.borderStyle = UITextBorderStyleRoundedRect;
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
    self.student.picture = @"miku2.jpg";
}

- (void)cancelAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveAction {
    
    [self.delegate addTableViewByContact:self.student];
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
