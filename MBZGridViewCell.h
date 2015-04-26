//
// Created by Maksim Bazarov on 10.04.15.
// Copyright (c) 2015 Maksim Bazarov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MBZGridViewCell : UIView
/**
* Label
*/
@property(nonatomic, strong) UILabel *label;

/**
* left Label
*/
@property(nonatomic, strong) UILabel *leftLabel;
/**
* Separator
*/
@property(nonatomic, strong) UIView *separator;


@end