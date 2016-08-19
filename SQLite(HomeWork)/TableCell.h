//
//  TableCell.h
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class peopleModel;

@interface TableCell : UITableViewCell {
    
    __weak IBOutlet UILabel *nameLabel;
    
    __weak IBOutlet UILabel *ageLable;
}

@property (nonatomic, strong) peopleModel *model;

@end
