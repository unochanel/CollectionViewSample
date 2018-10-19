//
//  TagLayout.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/18.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import Foundation
import UIKit

public protocol TagCellLayoutDelegate: NSObjectProtocol {
    func tagCellLayoutTagSize(layout: TagCellLayout, atIndex index:Int) -> CGSize
}

struct LayoutInfo {
    var layoutAttribute: UICollectionViewLayoutAttributes
    var whiteSpace: CGFloat = 0.0
    var isFirstElementInARow = false
    
    init(layoutAttribute: UICollectionViewLayoutAttributes) {
        self.layoutAttribute = layoutAttribute
    }
}

public class TagCellLayout: UICollectionViewLayout {
    
    var layoutInfoList: [LayoutInfo] = []
    var numberOfTagsInCurrentRow = 0
    var currentTagIndex: Int = 0
    var totalRowCount: Int!
    
    weak var delegate: TagCellLayoutDelegate?
    
    //MARK: - Init Methods
    
    public init(delegate: TagCellLayoutDelegate?) {
        self.delegate = delegate
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override convenience init() {
        self.init(delegate: nil)
    }

    override public func prepare() {
        resetLayoutState()
        setupTagCellLayout()
    }
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard layoutInfoList.count > indexPath.row else { return nil }
        return layoutInfoList[indexPath.row].layoutAttribute
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard !layoutInfoList.isEmpty else { return nil }
        return layoutInfoList
            .lazy
            .map { $0.layoutAttribute }
            .filter { rect.intersects($0.frame) }
    }
    
    override public var collectionViewContentSize: CGSize {
        let width = collectionViewWidth
        let height = layoutInfoList
            .filter { $0.isFirstElementInARow }
            .reduce(0, { $0 + $1.layoutAttribute.frame.height} )
        //totalのrowCountをすることで、CollectionViewの高さを調節することができます。
        return CGSize(width: width, height: height + CGFloat(totalRowCount*12))
    }
}

private extension TagCellLayout {
    var currentTagFrame: CGRect {
        guard let info = currentTagLayoutInfo?.layoutAttribute else { return .zero }
        var frame = info.frame
        //ここを変更すれば、各セルの横幅の余白が作れます！
        frame.origin.x += info.bounds.width + 12
        return frame
    }
    
    var currentTagLayoutInfo: LayoutInfo? {
        let index = max(0, currentTagIndex - 1)
        guard layoutInfoList.count > index else { return nil }
        return layoutInfoList[index]
    }
    
    var tagsCount: Int {

        return collectionView?.numberOfItems(inSection: 0) ?? 0
    }
    
    var collectionViewWidth: CGFloat {
        return collectionView?.frame.size.width ?? 0
    }
    
    var isLastRow: Bool {
        return currentTagIndex == (tagsCount - 1)
    }
    
    func setupTagCellLayout() {
        guard delegate != nil, collectionView != nil else { return }
        basicLayoutSetup()
        handleTagAlignment()
    }
    
    func basicLayoutSetup() {
        (0 ..< tagsCount).forEach {
            currentTagIndex = $0
            createLayoutAttributes()
            configureWhiteSpace()
            configurePositionForNextTag()
            handleWhiteSpaceForLastRow()
        }
    }

    func createLayoutAttributes() {
        let tagSize = delegate!.tagCellLayoutTagSize(layout: self, atIndex: currentTagIndex)
        let layoutInfo = tagCellLayoutInfo(tagIndex: currentTagIndex, tagSize: tagSize)
        layoutInfoList.append(layoutInfo)
    }

    func configureWhiteSpace() {
        let layoutInfo = layoutInfoList[currentTagIndex].layoutAttribute
        let tagWidth = layoutInfo.frame.size.width
        if shouldMoveTagToNextRow(tagWidth: tagWidth) {
            applyWhiteSpace(startingIndex: (currentTagIndex - 1))
        }
    }

    func tagCellLayoutInfo(tagIndex: Int, tagSize: CGSize) -> LayoutInfo {
        var isFirstElementInARow = tagIndex == 0
        var tagFrame = currentTagFrame
        tagFrame.size = tagSize

        if shouldMoveTagToNextRow(tagWidth: tagSize.width) {
            tagFrame.origin.x = 0.0
            //ここいじれば、列ごとのセルの間隔を変更することができます(変更した間隔は、collectionViewに反映されません）
            tagFrame.origin.y += (currentTagFrame.height + 10)
            totalRowCount += 1
            isFirstElementInARow = true
        }
        let attribute = layoutAttribute(tagIndex: tagIndex, tagFrame: tagFrame)
        var info = LayoutInfo(layoutAttribute: attribute)
        info.isFirstElementInARow = isFirstElementInARow
        return info
    }
    
    func shouldMoveTagToNextRow(tagWidth: CGFloat) -> Bool {
        return ((currentTagFrame.origin.x + tagWidth) > collectionViewWidth)
    }
    
    func layoutAttribute(tagIndex: Int, tagFrame: CGRect) -> UICollectionViewLayoutAttributes {
        let indexPath = IndexPath(item: tagIndex, section: 0)
        let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        layoutAttribute.frame = tagFrame
        return layoutAttribute
    }
    
    func applyWhiteSpace(startingIndex: Int) {
        let lastIndex = startingIndex - numberOfTagsInCurrentRow
        let whiteSpace = calculateWhiteSpace(tagIndex: startingIndex)
        
        for tagIndex in (lastIndex+1) ..< (startingIndex+1) {
            insertWhiteSpace(tagIndex: tagIndex, whiteSpace: whiteSpace)
        }
    }
    
    func calculateWhiteSpace(tagIndex: Int) -> CGFloat {
        let tagFrame = tagFrameForIndex(tagIndex: tagIndex)
        let whiteSpace = collectionViewWidth - (tagFrame.origin.x + tagFrame.size.width)
        return whiteSpace
    }
    
    func insertWhiteSpace(tagIndex: Int, whiteSpace: CGFloat) {
        var info = layoutInfoList[tagIndex]
        info.whiteSpace = whiteSpace/2
        layoutInfoList[tagIndex] = info
    }
    
    func tagFrameForIndex(tagIndex: Int) -> CGRect {
        let tagFrame =  tagIndex > -1 ? layoutInfoList[tagIndex].layoutAttribute.frame : .zero
        return tagFrame
    }
    
    func configurePositionForNextTag() {
        let layoutInfo = layoutInfoList[currentTagIndex].layoutAttribute
        let moveTag = shouldMoveTagToNextRow(tagWidth: layoutInfo.frame.size.width)
        numberOfTagsInCurrentRow = moveTag ? 1 : (numberOfTagsInCurrentRow + 1)
    }
    
    func handleTagAlignment() {
        let tagsCount = collectionView!.numberOfItems(inSection: 0)
        for tagIndex in 0 ..< tagsCount {
            var tagFrame = layoutInfoList[tagIndex].layoutAttribute.frame
            let whiteSpace = layoutInfoList[tagIndex].whiteSpace
            tagFrame.origin.x += whiteSpace
            let tagAttribute = layoutAttribute(tagIndex: tagIndex, tagFrame: tagFrame)
            layoutInfoList[tagIndex].layoutAttribute = tagAttribute
        }
    }
    
    func handleWhiteSpaceForLastRow() {
        guard isLastRow else { return }
        applyWhiteSpace(startingIndex: (tagsCount-1))
    }

    func resetLayoutState() {
        layoutInfoList = Array<LayoutInfo>()
        numberOfTagsInCurrentRow = 0
        totalRowCount = 0
    }
}
