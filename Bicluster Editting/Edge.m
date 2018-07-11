//
//  Edge.m
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/11/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import "Edge.h"

@implementation Edge

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_leftNode forKey:@"leftNode"];
    [encoder encodeObject:_rightNode forKey:@"rightNode"];
    [encoder encodeBool:_exists forKey:@"exists"];
    [encoder encodeFloat:_cValue forKey:@"cValue"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    if ((self = [super init])){
        _leftNode = [decoder decodeObjectForKey:@"leftNode"];
        _rightNode = [decoder decodeObjectForKey:@"rightNode"];
        _exists = [decoder decodeBoolForKey:@"exists"];
        _cValue = [decoder decodeFloatForKey:@"cValue"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    Edge *edgeCopy = [[Edge alloc]init];
    edgeCopy.leftNode = _leftNode;
    edgeCopy.rightNode = _rightNode;
    edgeCopy.exists = _exists;
    edgeCopy.cValue = _cValue;
    
    return edgeCopy;
}

@end
