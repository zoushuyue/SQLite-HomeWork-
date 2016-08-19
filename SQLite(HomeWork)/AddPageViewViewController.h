//
//  AddPageViewViewController.h
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPageViewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameT;
@property (weak, nonatomic) IBOutlet UITextField *pwdT;
@property (weak, nonatomic) IBOutlet UITextField *ageT;

- (IBAction)AddAction:(id)sender;

@end
