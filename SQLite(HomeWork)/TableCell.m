//
//  TableCell.m
//  SQLite(HomeWork)
//
//  Created by mac1 on 16/8/16.
//  Copyright © 2016年 fuxi. All rights reserved.
//

#import "TableCell.h"
#import "peopleModel.h"

@implementation TableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setModel:(peopleModel *)model {
    
    _model = model;
    
    //姓名
    nameLabel.text = model.name;
    ageLable.text = [NSString stringWithFormat:@"%d", model.age];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
