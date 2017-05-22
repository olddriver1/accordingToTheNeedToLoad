//
//  TableViewCell.m
//  accordingToTheNeedToLoad
//
//  Created by 郭杭 on 17/5/22.
//  Copyright © 2017年 郭杭. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell {
UIImageView *imageView;
    UILabel *label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        imageView.image = [UIImage imageNamed:@"7cd742c7d2619de54b096fd1bbf1"];
        [self.contentView addSubview:imageView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        label.text = @"2017年 郭杭. All rights reserved.";
        label.textColor = [UIColor orangeColor];
        [self.contentView addSubview:label];
    }
    
    return self;
}

- (void)openHidden {
    label.hidden = YES;
    imageView.hidden = YES;
}

- (void)closeHide {
    label.hidden = NO;
    imageView.hidden = NO;
}

@end
