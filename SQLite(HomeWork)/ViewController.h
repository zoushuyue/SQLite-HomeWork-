//
//  ViewController.h
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *uoLoadItem;//刷新按钮

@property (weak, nonatomic) IBOutlet UIBarButtonItem *AddItem;//添加按钮

@property (weak, nonatomic) IBOutlet UITableView *tableView;//表视图
@end

