//
//  PopupDialogTransitionAnimations.swift
//
//  Copyright (c) 2016 Orderella Ltd. (http://orderella.co.uk)
//  Author - Martin Wildfeuer (http://www.mwfire.de)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import UIKit

/*!
 Presentation transition styles for the popup dialog

 - BounceUp:   Dialog bounces in from bottom and is dismissed to bottom
 - BounceDown: Dialog bounces in from top and is dismissed to top
 - ZoomIn:     Dialog zooms in and is dismissed by zooming out
 - FadeIn:     Dialog fades in and is dismissed by fading out
 */
@objc public enum PopupDialogTransitionStyle: Int {
    case BounceUp
    case BounceDown
    case ZoomIn
    case FadeIn
}

/// Dialog bounces in from bottom and is dismissed to bottom
final internal class BounceUpTransition: TransitionAnimator {

    init(direction: AnimationDirection) {
        super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
    }

    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(transitionContext)

        switch direction {
        case .In:
            to.view.bounds.origin = CGPoint(x: 0, y: -from.view.bounds.size.height)
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: {
                self.to.view.bounds = self.from.view.bounds
            }) { (completed) in
                transitionContext.completeTransition(completed)
            }
        case .Out:
            UIView.animateWithDuration(outDuration, delay: 0.0, options: [.CurveEaseIn], animations: {
                self.from.view.bounds.origin = CGPoint(x: 0, y: -self.from.view.bounds.size.height)
                self.from.view.alpha = 0.0
            }) { (completed) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        }
    }
}


/// Dialog bounces in from top and is dismissed to top
final internal class BounceDownTransition: TransitionAnimator {

    init(direction: AnimationDirection) {
        super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
    }

    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(transitionContext)

        switch direction {
        case .In:
            to.view.bounds.origin = CGPoint(x: 0, y: from.view.bounds.size.height)
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: {
                self.to.view.bounds = self.from.view.bounds
            }) { (completed) in
                transitionContext.completeTransition(completed)
            }
        case .Out:
            UIView.animateWithDuration(outDuration, delay: 0.0, options: [.CurveEaseIn], animations: {
                self.from.view.bounds.origin = CGPoint(x: 0, y: self.from.view.bounds.size.height)
                self.from.view.alpha = 0.0
            }) { (completed) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        }
    }
}

/// Dialog zooms in and is dismissed by zooming out
final internal class ZoomTransition: TransitionAnimator {

    init(direction: AnimationDirection) {
        super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
    }

    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(transitionContext)

        switch direction {
        case .In:
            to.view.transform = CGAffineTransformMakeScale(0.1, 0.1)
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: [.CurveEaseOut], animations: {
                self.to.view.transform = CGAffineTransformMakeScale(1, 1)
            }) { (completed) in
                transitionContext.completeTransition(completed)
            }
        case .Out:
            UIView.animateWithDuration(outDuration, delay: 0.0, options: [.CurveEaseIn], animations: {
                self.from.view.transform = CGAffineTransformMakeScale(0.1, 0.1)
                self.from.view.alpha = 0.0
            }) { (completed) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        }
    }
}

/// Dialog fades in and is dismissed by fading out
final internal class FadeTransition: TransitionAnimator {

    init(direction: AnimationDirection) {
        super.init(inDuration: 0.22, outDuration: 0.2, direction: direction)
    }

    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(transitionContext)

        switch direction {
        case .In:
            to.view.alpha = 0
            UIView.animateWithDuration(0.6, delay: 0.0, options: [.CurveEaseOut],
            animations: {
                self.to.view.alpha = 1
            }) { (completed) in
                transitionContext.completeTransition(completed)
            }
        case .Out:
            UIView.animateWithDuration(outDuration, delay: 0.0, options: [.CurveEaseIn], animations: {
                self.from.view.alpha = 0.0
            }) { (completed) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            }
        }
    }
}

/// Used for the always drop out animation with pan gesture dismissal
final internal class DismissInteractiveTransition: TransitionAnimator {

    init() {
        super.init(inDuration: 0.22, outDuration: 0.32, direction: .Out)
    }

    override func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(transitionContext)
        UIView.animateWithDuration(outDuration, delay: 0.0, options: [], animations: {
            self.from.view.bounds.origin = CGPoint(x: 0, y: -self.from.view.bounds.size.height)
            self.from.view.alpha = 0.0
        }) { (completed) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
