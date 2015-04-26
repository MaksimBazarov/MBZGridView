//
// Created by Maksim Bazarov on 11.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import "MBZGridView.h"
#import "MBZGridViewDelegate.h"
#import "MBZGridViewDataSource.h"
#import "MBZGridViewLeftHeaderCell.h"
#import "MBZGridViewTopHeaderCell.h"


@interface MBZGridView ()

@property(nonatomic, strong) UIScrollView *topHeaderView;
@property(nonatomic, strong) UIScrollView *leftHeaderView;
@property(nonatomic, strong) UIScrollView *contentView;


@property(nonatomic, assign, readonly) CGFloat headerRowHeight;
@property(nonatomic, assign, readonly) CGFloat headerColumnWidth;

@property(nonatomic, strong) NSMutableDictionary *leftCells;
@property(nonatomic, strong) NSMutableDictionary *topCells;
@property(nonatomic, strong) NSMutableDictionary *contentCells;

@end

@implementation MBZGridView

#pragma mark - Initializtion

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self setupGlobal];
    return self;

}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupGlobal];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupGlobal];
    }
    return self;
}

- (UIScrollView *)topHeaderView {
    if (!_topHeaderView) {
        _topHeaderView = [[UIScrollView alloc] init];
    }
    return _topHeaderView;
}

- (UIScrollView *)leftHeaderView {
    if (!_leftHeaderView) {
        _leftHeaderView = [[UIScrollView alloc] init];
    }
    return _leftHeaderView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
    }
    return _contentView;
}

- (NSMutableDictionary *)leftCells {
    if (!_leftCells) {
        _leftCells = [[NSMutableDictionary alloc] init];
    }
    return _leftCells;
}

- (NSMutableDictionary *)topCells {
    if (!_topCells) {
        _topCells = [[NSMutableDictionary alloc] init];
    }
    return _topCells;
}

- (NSMutableDictionary *)contentCells {
    if (!_contentCells) {
        _contentCells = [[NSMutableDictionary alloc] init];
    }
    return _contentCells;
}

- (void)setupGlobal {
    [self configureTopHeaderView];
    [self configureLeftHeaderView];
    [self configureContentView];
}

- (void)configureContentView {
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
    self.contentView.delegate = self;

}

- (void)configureLeftHeaderView {
    self.leftHeaderView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.leftHeaderView];
    self.leftHeaderView.delegate = self;
}

- (void)configureTopHeaderView {
    self.topHeaderView.backgroundColor = [UIColor whiteColor];
    self.topHeaderView.delegate = self;
    [self addSubview:self.topHeaderView];
}

#pragma mark - Update

- (void)reloadData {
    [self clearAllCells];
    //Layout scroll views
    [self layoutLeftHeaderView];
    [self layoutTopHeaderView];
    [self layoutContentView];
    //create cells
    [self createLeftHeaderCells];
    [self createTopHeaderCells];
    [self createContentCells];

}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutLeftHeaderView];
    [self layoutTopHeaderView];
    [self layoutContentView];
}

- (void)layoutContentView {
    CGFloat height = CGRectGetHeight(self.bounds) - self.headerRowHeight;
    CGFloat width = CGRectGetWidth(self.bounds) - self.headerColumnWidth;
    CGFloat top = 0 + self.headerRowHeight;
    CGFloat left = 0 + self.headerColumnWidth;

    self.contentView.frame = CGRectMake(left, top, width, height);

}

- (void)layoutLeftHeaderView {
    CGFloat height = CGRectGetHeight(self.bounds) - self.headerRowHeight;
    CGFloat width = self.headerColumnWidth;
    CGFloat top = 0 + self.headerRowHeight;
    CGFloat left = 0;

    self.leftHeaderView.frame = CGRectMake(left, top, width, height);


}

- (void)layoutTopHeaderView {
    CGFloat height = self.headerRowHeight;
    CGFloat width = CGRectGetWidth(self.bounds) - self.headerColumnWidth;
    CGFloat top = 0;
    CGFloat left = 0 + self.headerColumnWidth;

    self.topHeaderView.frame = CGRectMake(left, top, width, height);
}

#pragma mark - Cells Creation

- (void)createLeftHeaderCells {
    NSInteger rowsCount = [self.dataSource numberOfRowsInGridView:self];
    for (NSInteger row = 0; row < rowsCount; ++row) {
        MBZGridViewLeftHeaderCell *cell = [self.dataSource gridView:self leftHeaderForRow:row];
        cell.separator.hidden = NO;
        if (cell) {
            //Cell content view layout
            CGFloat x = 0;
            CGFloat y = row * self.headerRowHeight;
            CGRect frame = CGRectMake(x, y, self.headerColumnWidth, self.headerRowHeight);
            cell.frame = frame;
            cell.delegate = self;
            cell.index = row;
            [self addleftHeaderCell:cell forRow:row];
        }
        self.leftHeaderView.contentSize = CGSizeMake(self.headerColumnWidth, rowsCount * self.headerRowHeight);
        self.leftHeaderView.contentInset = self.contentInset;
    }
}


- (void)createTopHeaderCells {

    NSInteger columnsCount = [self.dataSource numberOfColumnsInGridView:self];
    CGFloat contentWidth = 0;
    for (NSInteger col = 0; col < columnsCount; ++col) {
        MBZGridViewTopHeaderCell *cell = [self.dataSource gridView:self topHeaderForCol:col];
        CGFloat columnWidth = [self.delegate widthForColumn:(NSUInteger) col gridView:self];
        CGFloat x = contentWidth;
        contentWidth += columnWidth;
        if (cell) {
            //Cell content view layout
            CGFloat y = 0;
            CGRect frame = CGRectMake(x, y, columnWidth, self.headerRowHeight);
            cell.frame = frame;
            cell.delegate = self;
            cell.index = col;
            [self addTopHeaderCell:cell forCol:col];
        }
        self.topHeaderView.contentSize = CGSizeMake(contentWidth, self.headerRowHeight);
        self.topHeaderView.contentInset = UIEdgeInsetsZero;
    }
}

- (void)createContentCells {

    NSInteger columnsCount = [self.dataSource numberOfColumnsInGridView:self];
    NSInteger rowsCount = [self.dataSource numberOfRowsInGridView:self];
    CGFloat contentWidth = 0;

    for (NSInteger column = 0; column < columnsCount; ++column) {
        CGFloat columnWidth = [self.delegate widthForColumn:column gridView:self];
        CGFloat x = contentWidth;
        contentWidth += columnWidth;
        for (NSInteger row = 0; row < rowsCount; ++row) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:column];
            MBZGridViewCell *cell = [self.dataSource gridView:self cellForRowAtIndexPath:indexPath];
            cell.separator.hidden = NO;
            if (cell) {
                //Add cell to store
                [self addContentCell:cell forColumn:column forRow:row];
                //Cell content view layout

                CGFloat y = row * self.headerRowHeight;
                CGRect frame = CGRectMake(x, y, columnWidth, self.headerRowHeight);
                cell.frame = frame;

            }

        }

    }

    self.contentView.contentSize = CGSizeMake(contentWidth, rowsCount * self.headerRowHeight);
    self.contentView.contentInset = self.leftHeaderView.contentInset;
}

- (void)addContentCell:(MBZGridViewCell *)cell forColumn:(NSInteger)column forRow:(NSInteger)row {
    NSString *key = [self contentCellKeyForRow:row col:column];
    if (![self.contentCells[key] isEqual:cell]) {
        self.contentCells[key] = cell;
        [self.contentView addSubview:cell];
    }
}

- (void)addleftHeaderCell:(MBZGridViewLeftHeaderCell *)cell forRow:(NSInteger)row {
    if (![self.leftCells[@(row)] isEqual:cell]) {
        self.leftCells[@(row)] = cell;
        [self.leftHeaderView addSubview:cell];
    }
}

- (void)addTopHeaderCell:(MBZGridViewTopHeaderCell *)cell forCol:(NSInteger)col {
    if (![self.topCells[@(col)] isEqual:cell]) {
        self.topCells[@(col)] = cell;
        [self.topHeaderView addSubview:cell];
    }
}

#pragma mark - Reusable

- (MBZGridViewLeftHeaderCell *)dequeueReusableLeftHeaderCellForRow:(NSInteger)row {
    return self.leftCells[@(row)] ?: nil;
}

- (MBZGridViewTopHeaderCell *)dequeueReusableTopHeaderCellForCol:(NSInteger)col {
    return self.topCells[@(col)] ?: nil;
}

- (MBZGridViewCell *)dequeueReusablCellForRow:(NSInteger)row col:(NSInteger)col {
    NSString *key = [self contentCellKeyForRow:row col:col];
    return self.contentCells[key] ?: nil;
}

- (NSString *)contentCellKeyForRow:(NSInteger)row col:(NSInteger)col {
    NSString *key = [NSString stringWithFormat:@"%li:%li", (long) row, (long) col];
    return key;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([scrollView isEqual:self.contentView]) {
            self.topHeaderView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
            self.leftHeaderView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        }
        if ([scrollView isEqual:self.leftHeaderView] || [scrollView isEqual:self.topHeaderView]) {
            self.contentView.contentOffset = CGPointMake(
                    self.topHeaderView.contentOffset.x,
                    self.leftHeaderView.contentOffset.y
            );
        }
    });
}

#pragma mark - Helpers

- (void)clearAllCells {
    for (MBZGridViewLeftHeaderCell *cell in self.leftCells.allValues) {
        cell.label.text = @"";
        cell.leftLabel.text = @"";
        cell.frame = CGRectZero;
        cell.backgroundColor = [UIColor whiteColor];
    }

    for (MBZGridViewTopHeaderCell *cell in self.topCells.allValues) {
        cell.label.text = @"";
        cell.leftLabel.text = @"";
        cell.frame = CGRectZero;
        cell.backgroundColor = [UIColor whiteColor];
    }

    for (MBZGridViewCell *cell in self.contentCells.allValues) {
        cell.label.text = @"";
        cell.leftLabel.text = @"";
        cell.frame = CGRectZero;
        cell.backgroundColor = [UIColor whiteColor];
    }


}

- (CGFloat)headerRowHeight {
    CGFloat height = [self.delegate heightForHeaderForGridView:self];
    return height ?: 30.f;

}

- (CGFloat)headerColumnWidth {
    CGFloat width = [self.delegate widthForHeaderForGridView:self];
    return width ?: 75.f;
}

#pragma mark - MBZGridViewCellDelegate

- (void)didTapCell:(MBZGridViewHeaderCell *)cell {
    [self.delegate didSelectHeaderCell:cell];
}


@end