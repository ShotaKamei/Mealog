//
//  CarouselCollectionViewFlowLayout.swift
//  Mealog
//
//  Created by 亀井翔太 on 2022/09/23.
//

import UIKit

class CarouselCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
            guard let collectionView = collectionView else { return .zero }
            let pageWidth = itemSize.width + minimumLineSpacing
            let currentPage = collectionView.contentOffset.x / pageWidth

            if abs(velocity.x) > 0.2 {
                let nextPage = (velocity.x > 0) ? ceil(currentPage) : floor(currentPage)
                return CGPoint(x: nextPage * pageWidth, y: proposedContentOffset.y)
            } else {
                return CGPoint(x: round(currentPage) * pageWidth, y: proposedContentOffset.y)
            }
        }
}
