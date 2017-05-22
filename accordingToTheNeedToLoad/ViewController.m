//
//  ViewController.m
//  accordingToTheNeedToLoad
//
//  Created by 郭杭 on 17/5/22.
//  Copyright © 2017年 郭杭. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

static NSString *identifier = @"identifier";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController {
    NSMutableArray *datas;
    NSMutableArray *needLoadArr;
    BOOL scrollToToping;
    UITableView *ghTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    needLoadArr = [[NSMutableArray alloc] init];
    datas = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
    
    ghTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    ghTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [ghTableView registerClass:[TableViewCell class] forCellReuseIdentifier:identifier];
    ghTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    ghTableView.scrollIndicatorInsets = ghTableView.contentInset;
    ghTableView.dataSource = self;
    ghTableView.delegate = self;
    [self.view addSubview:ghTableView];
}

#pragma make - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (needLoadArr.count>0 && [needLoadArr indexOfObject:indexPath] == NSNotFound) {
        [cell openHidden];
    }else {
        [cell closeHide];
    }
    
    return cell;
}

// 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSIndexPath *ip = [ghTableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *cip = [[ghTableView indexPathsForVisibleRows] firstObject];
    NSInteger skipCount = 8;
    if (labs(cip.row-ip.row)>skipCount) {
        NSArray *temp = [ghTableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, ghTableView.frame.size.width, ghTableView.frame.size.height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y < 0) {
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row+3 < datas.count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
            }
        } else {
            NSIndexPath *indexPath = [temp firstObject];
            if (indexPath.row > 3) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
            }
        }
        // 需要按需加载的index
        [needLoadArr addObjectsFromArray:arr];
    }
}

// 开始滚动时清空数组
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [needLoadArr removeAllObjects];
}

@end
