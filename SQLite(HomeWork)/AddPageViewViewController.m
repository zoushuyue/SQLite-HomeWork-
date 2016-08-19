//
//  AddPageViewViewController.m
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "AddPageViewViewController.h"
#import "DataBaseManager.h"
#import "peopleModel.h"

@interface AddPageViewViewController () {
    peopleModel *model;
    DataBaseManager *manager;
}

@end

@implementation AddPageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   manager  = [DataBaseManager shareManager];
    
}



- (IBAction)AddAction:(id)sender {
    model = [[peopleModel alloc] init];
    
    model.name =  _userNameT.text;
    model.pwd = _pwdT.text;
    model.age = [_ageT.text intValue];
    NSLog(@"_usenameT = %@", _userNameT);
//    
//    NSLog(@"pwd = %@", _pwdT);
//    NSLog(@"age = %@", _ageT);
//    NSLog(@"model1 = %@", model);
//   
    [manager addPeopleModel:model];
    
    //查询数据
    NSArray *allArray = [manager queryAllModel];
    NSLog(@"%@", allArray);


}
@end
