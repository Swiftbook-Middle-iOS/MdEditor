//
//  File.swift
//  
//
//  Created by Александр Мамлыго on /252/2567 BE.
//

import Foundation

public protocol IVisitor {
	associatedtype Result

	func visit(node: Document) -> [Result]
	func visit(node: HeaderNode) -> Result
	func visit(node: ParagraphNode) -> Result
	func visit(node: BlockquoteNode) -> Result
	func visit(node: TextNode) -> Result
	func visit(node: BoldTextNode) -> Result
	func visit(node: ItalicTextNode) -> Result
	func visit(node: BoldItalicTextNode) -> Result
	func visit(node: ImageNode) -> Result
	func visit(node: EscapedCharNode) -> Result
	func visit(node: InlineCodeNode) -> Result
	func visit(node: CodelineNode) -> Result
	func visit(node: LinebreakNode) -> Result
	func visit(node: TaskNode) -> Result
	func visit(node: CodeblockNode) -> Result
	func visit(node: OrderedListNode) -> Result
	func visit(node: OrderedListItemNode) -> Result
	func visit(node: UnorderedListNode) -> Result
	func visit(node: UnorderedListItemNode) -> Result
}

extension IVisitor {
	func visitChidren(of node: INode) -> [Result] {
		return node.children.compactMap { childNode in
			switch childNode {
			case let child as HeaderNode:
				return visit(node: child)
			case let child as ParagraphNode:
				return visit(node: child)
			case let child as BlockquoteNode:
				return visit(node: child)
			case let child as TextNode:
				return visit(node: child)
			case let child as BoldTextNode:
				return visit(node: child)
			case let child as ItalicTextNode:
				return visit(node: child)
			case let child as BoldItalicTextNode:
				return visit(node: child)
			case let child as ImageNode:
				return visit(node: child)
			case let child as EscapedCharNode:
				return visit(node: child)
			case let child as InlineCodeNode:
				return visit(node: child)
			case let child as LinebreakNode:
				return visit(node: child)
			case let child as TaskNode:
				return visit(node: child)
			case let child as CodelineNode:
				return visit(node: child)
			case let child as CodeblockNode:
				return visit(node: child)
			case let child as OrderedListNode:
				return visit(node: child)
			case let child as OrderedListItemNode:
				return visit(node: child)
			case let child as UnorderedListNode:
				return visit(node: child)
			case let child as UnorderedListItemNode:
				return visit(node: child)
			default:
				return nil
			}
		}
	}
}
