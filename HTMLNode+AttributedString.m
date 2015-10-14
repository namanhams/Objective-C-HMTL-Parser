//
//  HTMLNode+AttributedString.m
//  HttmlParserSample
//
//  Created by Pham Hoang Le on 14/10/15.
//  Copyright © 2015 Pham Hoang Le. All rights reserved.
//

#import "HTMLNode+AttributedString.h"

@implementation HTMLNode (AttributedString)

- (NSAttributedString *) attributedString:(NSDictionary *(^)(HTMLNodeType))attributesForNodeType {
    return [HTMLNode traverseNode:self attributesForNodeType:attributesForNodeType];
}

+ (NSAttributedString *) traverseNode:(HTMLNode *)node attributesForNodeType:(NSDictionary *(^)(HTMLNodeType))attributesForNodeType {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    for(int i = 0; i < node.children.count; i++) {
        [string appendAttributedString:[self traverseNode:node.children[i] attributesForNodeType:attributesForNodeType]];
    }
        
    if(node.nodetype == HTMLTextNode && node.rawContents != nil)
        [string appendAttributedString:[[NSAttributedString alloc] initWithString:node.rawContents]];
    
    // Apply attributes
    if(attributesForNodeType != nil) {
        NSDictionary *attributes = attributesForNodeType(node.nodetype);
        if(attributes != nil)
            [string setAttributes:attributes range:NSMakeRange(0, string.length)];
    }
    
    return string;
}

@end
