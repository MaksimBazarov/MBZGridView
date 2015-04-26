//
// Created by Maksim Bazarov on 11.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import "MBZGridViewHeaderCell.h"
#import "MBZGridViewCellDelegate.h"


@implementation MBZGridViewHeaderCell


- (instancetype)init {
    self = [super init];
    [self setup];
    return self;
}

- (void)setup {
    self.label.font = [UIFont systemFontOfSize:13];
    self.leftLabel.clipsToBounds = YES;
    self.label.clipsToBounds = YES;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:recognizer];

}
#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame =  CGRectMake(5, 2, CGRectGetWidth(self.bounds)-10, CGRectGetHeight(self.bounds)-4);
    self.leftLabel.frame =  CGRectMake(0, 0, 0, 0);
}

- (BOOL)needsUpdateConstraints {
    return NO;
}

#pragma mark - Actions

-(void)didTap {
    [self.delegate didTapCell:self];
}

@end