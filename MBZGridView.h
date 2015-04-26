//
// Created by Maksim Bazarov on 11.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBZGridViewCellDelegate.h"

@protocol MBZGridViewDelegate;
@protocol MBZGridViewDataSource;
@class MBZGridViewLeftHeaderCell;
@class MBZGridViewTopHeaderCell;
@class MBZGridViewCell;


@interface MBZGridView : UIView <UIScrollViewDelegate, MBZGridViewCellDelegate>

@property(nonatomic, weak) id <MBZGridViewDelegate> delegate;
@property(nonatomic, weak) id <MBZGridViewDataSource> dataSource;

@property(nonatomic, assign) CGFloat columnWidth;
@property(nonatomic, assign) CGFloat rowHeight;


@property(nonatomic, assign) UIEdgeInsets contentInset;

-(void)reloadData;

- (MBZGridViewLeftHeaderCell *)dequeueReusableLeftHeaderCellForRow:(NSInteger)row;

- (MBZGridViewTopHeaderCell *)dequeueReusableTopHeaderCellForCol:(NSInteger)col;

- (MBZGridViewCell *)dequeueReusablCellForRow:(NSInteger)row col:(NSInteger)col;

@end