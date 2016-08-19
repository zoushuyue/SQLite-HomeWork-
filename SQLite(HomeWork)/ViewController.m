//
//  ViewController.m
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "ViewController.h"
#import "TableCell.h"
#import "DataBaseManager.h"
#import "peopleModel.h"
#import <sqlite3.h>
#import "EditViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource> {
    DataBaseManager *manager;
    peopleModel *model;
}

@property (nonatomic, strong) NSArray *data;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSHomeDirectory());
    

    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
//    //获取数据
    model = [[peopleModel alloc] init];
    manager = [DataBaseManager shareManager];
//        [manager queryAllModel];
    self.data = [manager queryAllModel];
    NSLog(@"_data = %@", _data);
    NSLog(@"model= %@", model);
    
    [self.tableView reloadData];
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //数据库管理类
    manager = [DataBaseManager shareManager];
    self.data = [manager queryAllModel];
    [self.tableView reloadData];
}


#pragma mark - UITableView DataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        //xib
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableCell" owner:self options:nil] lastObject];
        
        cell.model = self.data[indexPath.row];
        
        cell.backgroundColor = [UIColor yellowColor];

    }
    
    
    return cell;
}


- (IBAction)upLoadView:(id)sender {
    
    self.data = [manager queryAllModel];
    [self.tableView reloadData];
}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    EditViewController *editVC = [[EditViewController alloc] init];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    EditViewController *editVC = [sb instantiateViewControllerWithIdentifier:@"EditViewController"];
   
    editVC.model = _data[indexPath.row];
    [self.navigationController pushViewController:editVC animated:YES];
    

//    self.label1.text =  self.model.name;
    
    
}



@end
