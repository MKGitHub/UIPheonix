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


final class DemoTableViewController:UIPBaseViewController, UIPBaseViewControllerProtocol, UIPButtonDelegate,
                                    NSTableViewDataSource, NSTableViewDelegate
{
    // MARK: Public IB Outlet
    @IBOutlet fileprivate weak var ibTableView:NSTableView!

    // MARK: Private Members
    fileprivate var mUIPheonix:UIPheonix!


    // MARK:- UIPBaseViewController/UIPBaseViewControllerProtocol


    ///
    /// Create a new instance of self with nib.
    ///
    static func newInstance<T:UIPBaseViewControllerProtocol>(with attributes:Dictionary<String, Any>)
    -> T
    {
        guard let vc:DemoTableViewController = DemoTableViewController.init(nibName:"\(self)", bundle:nil) else {
            fatalError("DemoCollectionViewController newInstance: Could not create new instance of `DemoCollectionViewController` from nib!")
        }

        // init member
        vc.mPreparedAttributes = attributes

        return vc as! T
    }


    // MARK:- Life Cycle


    override func viewDidLoad()
    {
        super.viewDidLoad()

        initUIPheonix()
        setupWithModels()
        setupTableView()
    }


    // MARK:- NSTableViewDataSource


    func numberOfRows(in tableView:NSTableView)
    -> Int
    {
        return mUIPheonix.count()
    }


    // MARK: NSTableViewDelegate


    func tableView(_ tableView:NSTableView, viewFor tableColumn:NSTableColumn?, row:Int)
    -> NSView?
    {
        return mUIPheonix.tableViewCell(for:row)
    }


    ///
    /// Is a delegate function, even if it is a notification handler.
    ///
    func tableViewSelectionDidChange(_ notification:Notification)
    {
        if (ibTableView.numberOfSelectedRows > 0)
        {
            ibTableView.deselectRow(ibTableView.selectedRow)
        }
    }


    func tableView(_ tableView:NSTableView, heightOfRow row:Int)
    -> CGFloat
    {
        return mUIPheonix.tableViewCellHeight(for:row)
    }


    func tableView(_ tableView:NSTableView, estimatedHeightForRowAt indexPath:IndexPath)
    -> CGFloat
    {
        return mUIPheonix.tableViewCellEstimatedHeight(for:indexPath)
    }


    // MARK:- UIPButtonDelegate


    func buttonAction(_ buttonId:Int)
    {
        switch (buttonId)
        {
            case ButtonId.helloWorld.rawValue:
                print("Hello World!")
            break

            default:
                fatalError("DemoTableViewController buttonAction: Unknown button id \(buttonId)!")
            break
        }
    }


    // MARK:- Private


    fileprivate func initUIPheonix()
    {
        mUIPheonix = UIPheonix(with:ibTableView, delegate:self)
    }


    fileprivate func setupWithModels()
    {
        mUIPheonix.setModelViewRelationships([SimpleButtonModel.nameOfClass:SimpleButtonModelTVCell.nameOfClass,
                                              SimpleLabelModel2.nameOfClass:SimpleLabelModelTVCell.nameOfClass,
                                              SimpleUserProfileModel.nameOfClass:SimpleUserProfileModelTVCell.nameOfClass])

        var models:[UIPBaseCellModel] = [UIPBaseCellModel]()

        ///
        /// Illustrate the usage of
        /// and that both self-sizing cells with constraints
        /// and the default build-in cells work just fine with auto-layout.
        ///

        models.append(SimpleButtonModel(id:ButtonId.helloWorld.rawValue, title:"Hello World!", alignment:SimpleButtonModel.Alignment.center))

        models.append(SimpleLabelModel2(text:"Label #1", backgroundColorHue:0.2))
        models.append(SimpleLabelModel2(text:"Label #2", backgroundColorHue:0.4))
        models.append(SimpleLabelModel2(text:"Label #3", backgroundColorHue:0.6))
        models.append(SimpleLabelModel2(text:"Label #4", backgroundColorHue:0.8))
        
        let simpleUserProfileModel1:SimpleUserProfileModel = SimpleUserProfileModel(title:"#1 The quick.", description:"Tilde coloring book health.")
        models.append(simpleUserProfileModel1)

        let simpleUserProfileModel2:SimpleUserProfileModel = SimpleUserProfileModel(title:"#2 The quick, brown fox jumps over a lazy dog.", description:"Tilde coloring book health goth echo park, gentrify semiotics vinyl cardigan quinoa meh master cleanse cray four dollar toast scenester hammock. Butcher truffaut flannel, unicorn fanny pack skateboard pug four loko.")
        models.append(simpleUserProfileModel2)

        mUIPheonix.setDisplayModels(models)
    }


    fileprivate func setupTableView()
    {
        ibTableView.delegate = self
        ibTableView.dataSource = self
        ibTableView.gridColor = NSColor.lightGray

        ///
        /// In our demo, we are using custom table view cell types.
        /// But if we were only using the built-in table cell types – this would be enough, because they all have a fixed height of 17 points.
        ///

        // From Apple documentation:
        // The value must be greater than 0.
        // Calling -setRowHeight: with a non-pixel aligning (fractional) value will be forced to a pixel aligning (integral) value.
        // For variable row height tableViews (ones that have the delegate implement -tableView:heightOfRow:), -rowHeight will be
        // used to draw alternating rows past the last row in the tableView.
        // The actual -rectOfRow: is equal to the -rowHeight plus the intercellSpacing.height.
        // The default value is 17.0 for applications linked on 10.5 and higher (the height acceptable for [NSFont systemFontSize]).
        // The default value is 16.0 for 10.4 and lower.
        //ibTableView.rowHeight = 17
    }
}

