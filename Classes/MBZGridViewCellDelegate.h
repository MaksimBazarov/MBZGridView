//
// Created by Maksim Bazarov on 14.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBZGridViewHeaderCell;

@protocol MBZGridViewCellDelegate <NSObject>

-(void)didTapCell:(MBZGridViewHeaderCell *)cell;

@end