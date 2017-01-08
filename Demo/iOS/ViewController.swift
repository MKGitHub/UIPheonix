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

import UIKit


final class ViewController:UIViewController
{
    override func viewDidAppear(_ animated:Bool)
    {
        super.viewDidAppear(animated)

        // start the UIPheonix iOS demo
        // create & present a new instance of the demo VC
        let demoViewController:DemoCollectionViewController = DemoCollectionViewController.newInstance(with:[DemoCollectionViewController.AttributeKeyName.appDisplayState:AppDisplayState.startUp])
        // or:
        //let demoViewController:DemoTableViewController = DemoTableViewController.newInstance(with:[:])

        // use custom view transition
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionFade
        self.navigationController!.view.layer.add(transition, forKey:nil)

        self.navigationController!.setViewControllers([demoViewController], animated:false)
        // or:
        //self.navigationController!.pushViewController(demoViewController, animated:false)
    }
}

