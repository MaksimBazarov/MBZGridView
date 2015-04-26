//
// Created by Maksim Bazarov on 10.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import "MBZGridViewCell.h"
@interface MBZGridViewCell()

@end

@implementation MBZGridViewCell {

}

- (instancetype)init {
    self = [super init];

    self.label.font = [UIFont systemFontOfSize:13];
    self.label.contentMode = UIViewContentModeTop;
    self.leftLabel.font = [UIFont systemFontOfSize:13];
    self.leftLabel.contentMode = UIViewContentModeTop;
    self.separator.backgroundColor = [UIColor colorWithRed:0.784 green:0.78 blue:0.8 alpha:1]; /*#c8c7cc*/
    self.separator.hidden = YES;
    [self addSubview:self.label];
    [self addSubview:self.leftLabel];
    [self addSubview:self.separator];
    self.clipsToBounds = YES;

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(25, 5, CGRectGetWidth(self.bounds)-30, CGRectGetHeight(self.bounds)-10);
    self.leftLabel.frame = CGRectMake(5, 5, 20, CGRectGetHeight(self.bounds)-10);
    self.separator.frame = CGRectMake(
            0,
            CGRectGetMaxY(self.bounds) - 0.3f,
            CGRectGetWidth(self.bounds),
            CGRectGetMaxY(self.bounds));
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
    }
    return _leftLabel;
}

- (UIView *)separator {
    if (!_separator) {
        _separator = [[UIView alloc] init];
    }
    return _separator;
}



//- (BOOL)needsUpdateConstraints {
//    return NO;
//}

@end