//
// Created by Maksim Bazarov on 10.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBZGridViewCell;
@class MBZGridView;
@class MBZGridViewHeaderCell;
@class MBZGridViewTopHeaderCell;
@class MBZGridViewLeftHeaderCell;


@protocol MBZGridViewDataSource <NSObject>

@required


- (NSInteger)numberOfColumnsInGridView:(MBZGridView *)gridView;

- (NSInteger)numberOfRowsInGridView:(MBZGridView *)gridView;

- (MBZGridViewCell *)gridView:(MBZGridView *)gridView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (MBZGridViewLeftHeaderCell *)gridView:(MBZGridView *)gridView leftHeaderForRow:(NSInteger)row;

- (MBZGridViewTopHeaderCell *)gridView:(MBZGridView *)gridView topHeaderForCol:(NSInteger)col;


@optional
@end