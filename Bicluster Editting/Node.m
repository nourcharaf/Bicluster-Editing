//
//  Node.m
//  Bicluster Editting
//
//  Created by Mohammad Nour Sharaf on 7/2/18.
//  Copyright © 2018 Mohammad Nour Sharaf. All rights reserved.
//

#import "Node.h"

@implementation Node

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:_nodeId forKey:@"nodeId"];
    [encoder encodeObject:_nodeEdges forKey:@"nodeEdges"];
    [encoder encodeObject:_nodeView forKey:@"nodeView"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    if ((self = [super init])){
        _nodeId = [decoder decodeObjectForKey:@"nodeId"];
        _nodeEdges = [decoder decodeObjectForKey:@"nodeEdges"];
        _nodeView = [decoder decodeObjectForKey:@"nodeView"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    Node *nodeCopy = [[Node alloc]init];
    nodeCopy.nodeId = _nodeId;
    nodeCopy.nodeEdges = _nodeEdges;
    nodeCopy.nodeView = _nodeView;
    
    return nodeCopy;
}

@end
