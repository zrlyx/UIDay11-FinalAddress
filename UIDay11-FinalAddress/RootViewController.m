//
//  RootViewController.m
//  UIDay9-AddressBook
//
//  Created by LML on 15/11/25.
//  Copyright © 2015年 LML-PC. All rights reserved.
//

#import "PickerViewController.h"
#import "Contact.h"
#import "DetailViewController.h"
#import "AddViewController.h"
#import "NSString+CommonGit.h"
#import "BoyTableViewCell.h"
#import "GirlTableViewCell.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, DetailViewControllerDelegate, AddViewControllerDelegate>

@property(nonatomic, retain)NSMutableDictionary *manageStudent;
@property(nonatomic, assign)NSInteger studentNumber;
/**
 *  有序的key值
 */
@property(nonatomic, retain)NSMutableArray *keyResult;

/**
 *  使用的tableView
 */
@property(nonatomic, retain)UITableView *tableView;

@end

@implementation RootViewController

- (void)dealloc
{
    [_tableView release];
    [_manageStudent release];
    [_keyResult release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.title = @"通讯录";
    
    //设置右侧编辑按钮和左侧添加按钮
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    self.navigationItem.leftBarButtonItem = left;
    [left release];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView release];
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Class25ContactList" ofType:@"plist"]];
    
    //对字典的key进行有序处理
    NSArray *keys = data.allKeys;
    NSSortDescriptor *sortByKey = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    //将不可变数组(等号右侧)拷贝可变的.
    self.keyResult = [[keys sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortByKey, nil]] mutableCopy];
    
#warning 这个keyResult需要初始化或者copy自己的空间.不能直接指向别的数组.跳转的时候数组会被release. 出现异常 或者使用上述方法copy成一个可变的.
//    self.keyResult = [NSMutableArray arrayWithArray:keys];
    
    //使用新字典管理 字典套数组套学生类
    self.manageStudent = [NSMutableDictionary dictionary];
    
    for (NSString *groupName in self.keyResult) {
        
        [self.manageStudent setObject:[NSMutableArray array] forKey:groupName];
        
        for (NSDictionary *dic in [data objectForKey:groupName]) {
            
            Contact *student = [[Contact alloc] init];
            [student setValuesForKeysWithDictionary:dic];
            [[self.manageStudent objectForKey:groupName] addObject:student];
            self.studentNumber ++;
        }
    }
    
}

#pragma mark 设置编辑状态
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    //必须调用父类的方法!!!!
    [super setEditing:editing animated:animated];
    
    if (editing) {
        [self.tableView setEditing:YES animated:YES];
    } else{
        [self.tableView setEditing:NO animated:YES];
    }
}

#pragma mark 设置可以编辑的行
- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark 设置可以移动的行
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark 指定编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

#pragma mark 编辑完成
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *key = self.keyResult[indexPath.section];
        NSMutableArray *stu = [self.manageStudent objectForKey:key];
        
        if (stu.count == 1) {
            [self.keyResult removeObject:key];
            [stu removeObjectAtIndex:indexPath.row];
            [self.manageStudent removeObjectForKey:key];
            
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationTop];
            
//            [self.tableView reloadData];
            
            
        }else {
            [stu removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
}

#pragma mark 移动完成
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *key = self.keyResult[sourceIndexPath.section];
    NSMutableArray *stu = [self.manageStudent objectForKey:key];
    [stu exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
    [self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    
}

#pragma mark 限制移动的区域
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        return proposedDestinationIndexPath;
    }
    else {
        return sourceIndexPath;
    }
}

#pragma mark 添加按钮点击事件
- (void)addAction {
    
    AddViewController *add = [[AddViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:add];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.barTintColor = [UIColor colorWithWhite:0.890 alpha:1];
    add.delegate = self;
    [self presentViewController:nav animated:YES completion:nil];
    [add release];
    [nav release];
}

#pragma mark 更新学生事件
- (void)updateStudentDetail:(Contact *)contant index:(NSIndexPath *)indexPath {
 
    NSLog(@"%ld, %ld", indexPath.section, indexPath.row);
    NSString *key = self.keyResult[indexPath.section];
    NSArray *stu = [self.manageStudent objectForKey:key];
    Contact *student = stu[indexPath.row];
    
    student = contant;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

#pragma mark 添加学生协议方法
- (void)addTableViewByContact:(Contact *)contact {
    
    NSString *firstLetter = [NSString firstCharactor:contact.name];
    NSLog(@"%@", firstLetter);
    if ([self.keyResult containsObject:firstLetter]) {
        
        [[self.manageStudent objectForKey:firstLetter] addObject:contact];
    } else {
        [self.keyResult addObject:firstLetter];
        NSArray *keys = self.keyResult;
        NSSortDescriptor *sortByKey = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        keys = [keys sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortByKey, nil]];
        self.keyResult = [NSMutableArray arrayWithArray:keys];
        [self.manageStudent setObject:[NSMutableArray arrayWithObjects:contact, nil] forKey:firstLetter];
        
    }
    
    [self.tableView reloadData];
    
}


#pragma mark 返回分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //分区数为字典key数
    return self.manageStudent.count;
}

#pragma mark 返回分区头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    //title有序存在keyResult中
    return self.keyResult[section];
}

#pragma mark 返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //得到对应的学生
    NSString *key = self.keyResult[indexPath.section];
    NSArray *stu = [self.manageStudent objectForKey:key];
    Contact *student = stu[indexPath.row];
    
    if ([student.gender isEqualToString:@"男"]) {
        static NSString *identify = @"boy";
        BoyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[[BoyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify] autorelease];
        }
        
        cell.contact = student;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else {
        static NSString *identify = @"girl";
        GirlTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[GirlTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
        }
        cell.contact = student;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

#pragma mark 返回各个分区行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //得到每一个数组的值
    NSString *key = self.keyResult[section];
    NSArray *array = [self.manageStudent objectForKey:key];
    return array.count;
}

#pragma mark 返回右侧索引
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    //右侧的值为keyResult数组的值
    return self.keyResult;
    
}

#pragma mark tableView点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //得到对应的学生
    NSString *key = self.keyResult[indexPath.section];
    NSArray *stu = [self.manageStudent objectForKey:key];
    Contact *student = stu[indexPath.row];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    detail.student = student;
    detail.index = indexPath;
    detail.delegate = self;
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}

#pragma mark 返回分区高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
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
