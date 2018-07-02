//
//  NodeView.m
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/2/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import "NodeView.h"

@implementation NodeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setupView{
    _didSetupView = YES;
    
    // Circle View
    _circleView = [[UIView alloc]init];
    [_circleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_circleView];
    
    NSLayoutConstraint *circleViewTopConstraint = [NSLayoutConstraint constraintWithItem:_circleView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *circleViewLeadingConstraint = [NSLayoutConstraint constraintWithItem:_circleView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *circleViewTrailingConstraint = [NSLayoutConstraint constraintWithItem:_circleView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *circleViewBottomConstraint = [NSLayoutConstraint constraintWithItem:_circleView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self addConstraints:@[circleViewTopConstraint,circleViewLeadingConstraint,circleViewTrailingConstraint,circleViewBottomConstraint]];
    
    [self layoutIfNeeded];
    [_circleView setBackgroundColor:[UIColor redColor]];
    [_circleView.layer setBorderColor:[UIColor blackColor].CGColor];
    [_circleView.layer setBorderWidth:1];
    [_circleView.layer setCornerRadius:_circleView.frame.size.width/2];
    
    // Node Label
    _nodeLabel = [[UILabel alloc]init];
    [_nodeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:_nodeLabel];
    
    NSLayoutConstraint *nodeLabelCenterXConstraint = [NSLayoutConstraint constraintWithItem:_nodeLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_circleView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *nodeLabelCenterYConstraint = [NSLayoutConstraint constraintWithItem:_nodeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_circleView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self addConstraints:@[nodeLabelCenterXConstraint,nodeLabelCenterYConstraint]];
}

@end
