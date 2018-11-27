/**
    UIPheonix
    Copyright © 2016/2017/2018 Mohsan Khan. All rights reserved.

    https://github.com/MKGitHub/UIPheonix
    http://www.xybernic.com

    Copyright 2016/2017/2018 Mohsan Khan

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

import Cocoa


/**
    A nice view controller fade in/out effect.
*/
final class CustomViewControllerPresentationAnimator:NSObject, NSViewControllerPresentationAnimator
{
    @objc func animatePresentation(of viewController:NSViewController, from fromViewController:NSViewController)
    {
        if let window = fromViewController.view.window
        {
            NSAnimationContext.runAnimationGroup(
            {
                (context) -> Void in

                // this is the source view

                fromViewController.view.animator().alphaValue = 0
            },
            completionHandler:
            {
                () -> Void in

                // this is the destination view

                viewController.view.alphaValue = 0
                window.contentViewController = viewController    // replace
                viewController.view.animator().alphaValue = 1.0
            })
        }
    }


    @objc func animateDismissal(of viewController:NSViewController, from fromViewController:NSViewController)
    {
        if let window = viewController.view.window
        {
            NSAnimationContext.runAnimationGroup(
            {
                (context) -> Void in

                // this is the source view

                viewController.view.animator().alphaValue = 0
            },
            completionHandler:
            {
                () -> Void in

                // this is the destination view

                fromViewController.view.alphaValue = 0
                window.contentViewController = fromViewController    // replace
                fromViewController.view.animator().alphaValue = 1.0
            })
        }
    }
}

