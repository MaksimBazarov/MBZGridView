//
// Created by Maksim Bazarov on 11.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBZGridViewCell.h"

@protocol MBZGridViewCellDelegate;


@interface MBZGridViewHeaderCell : MBZGridViewCell

@property(nonatomic, weak) id <MBZGridViewCellDelegate> delegate;
@property(nonatomic, assign) NSInteger index;

@end