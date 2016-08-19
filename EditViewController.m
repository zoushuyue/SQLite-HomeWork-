//
//  EditViewController.m
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/17.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "EditViewController.h"
#import "DataBaseManager.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        self.label1.text = self.model.name;
    }
   return self;
}

- (void) setModel:(peopleModel *)model {
    _model = model;
    //因为是StoryBord创建的，textField 这个时候是空的，先调用set方法，然后是控件创建
   
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.name.text = self.model.name;
    self.age.text = [NSString stringWithFormat:@"%d", self.model.age];
    self.pwd.text = self.model.pwd;
    
    self.label1.text = self.model.name;
    
}

- (IBAction)upDataAction:(id)sender {
    
   DataBaseManager *manager =[DataBaseManager shareManager];
    
    peopleModel *model = [[peopleModel alloc] init];
    model.name = self.name.text;
    model.age = [self.age.text intValue];
    model.pwd = self.pwd.text;
    NSLog(@"model.name = %@", model.name);
    [manager updatePeopleModel:model];
    NSLog(@"model = %@", model);
}

@end
