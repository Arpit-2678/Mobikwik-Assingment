//
//  DetailTransitionAnimator.swift
//  Mobikwik Assingment
//
//  Created by Arpit Dwivedi on 26/02/24.
//

import Foundation
import UIKit

class DetailTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            // Retrieve the source and destination view controllers
            guard let fromVC = transitionContext.viewController(forKey: .from) as? MainViewController,
                  let toVC = transitionContext.viewController(forKey: .to) as? DetailViewController,
                  let selectedIndexPath = fromVC.collectionView.indexPathsForSelectedItems?.first,
                  let selectedCell = fromVC.collectionView.cellForItem(at: selectedIndexPath) as? ImageCollectionViewCell,
                  let selectedImageView = selectedCell.imageVw
                  else {
                transitionContext.completeTransition(false)
                return
            }
            
            // Set up the transition
            let containerView = transitionContext.containerView
            let initialFrame = selectedImageView.convert(selectedImageView.bounds, to: nil)
            let finalFrame = toVC.imageView.frame
            
            // Create a temporary image view for the transition
            let transitionImageView = UIImageView(frame: initialFrame)
            transitionImageView.image = selectedImageView.image
            transitionImageView.contentMode = .scaleAspectFill
            transitionImageView.clipsToBounds = true
            containerView.addSubview(transitionImageView)
            
            // Hide the selected image view during the transition
            selectedImageView.isHidden = true
            
            // Add the destination view controller's view to the container view
            containerView.addSubview(toVC.view)
            toVC.view.alpha = 0.0
            
            // Perform the transition animation
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                transitionImageView.frame = finalFrame
                toVC.view.alpha = 1.0
            }) { _ in
                // Clean up and complete the transition
                transitionImageView.removeFromSuperview()
                selectedImageView.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }

}
