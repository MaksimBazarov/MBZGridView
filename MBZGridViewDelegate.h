//
// Created by Maksim Bazarov on 10.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBZGridView;
@class MBZGridViewCell;
@class MBZGridViewLeftHeaderCell;

@protocol MBZGridViewDelegate <NSObject>

- (CGFloat)heightForHeaderForGridView:(MBZGridView *)gridView;
- (CGFloat)widthForHeaderForGridView:(MBZGridView *)gridView;
- (CGFloat)widthForColumn:(NSUInteger)column gridView:(MBZGridView *)gridView;

@optional

-(void)didSelectHeaderCell:(MBZGridViewHeaderCell *)cell;

@end