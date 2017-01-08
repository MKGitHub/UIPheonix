//
//  UIPheonix
//  Copyright © 2016/2017 Mohsan Khan. All rights reserved.
//

//
//  https://github.com/MKGitHub/UIPheonix
//  http://www.xybernic.com
//  http://www.khanofsweden.com
//

//
//  Copyright 2016/2017 Mohsan Khan
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Cocoa


class ViewController:NSViewController
{
    override func viewDidAppear()
    {
        super.viewDidAppear()

        // adjust window position
        if let window:NSWindow = self.view.window
        {
            window.setFrameOrigin(window.frame.offsetBy(dx:0, dy:200).origin)
        }

        // create a nice/delayed launch screen effect like in iOS
        DispatchQueue.main.asyncAfter(deadline:(.now() + .seconds(1)), execute:
        {
            // start the UIPheonix macOS demo
            // create & present a new instance of the demo VC
            let demoViewController:DemoCollectionViewController = DemoCollectionViewController.newInstance(with:[DemoCollectionViewController.AttributeKeyName.appDisplayState:AppDisplayState.startUp])
            // or:
            //let demoViewController:DemoTableViewController = DemoTableViewController.newInstance(with:[:])

            // present using a custom view controller presentation animator
            self.presentViewController(demoViewController, animator:CustomViewControllerPresentationAnimator())
        })
    }


    /*override var representedObject:Any?
    {
        didSet {
            // Update the view, if already loaded.
        }
    }*/
}

