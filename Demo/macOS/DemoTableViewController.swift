/**
    UIPheonix
    Copyright © 2016/2017/2018/2019 Mohsan Khan. All rights reserved.

    https://github.com/MKGitHub/UIPheonix
    http://www.xybernic.com

    Copyright 2016/2017/2018/2019 Mohsan Khan

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


final class DemoTableViewController:UIPBaseViewController, UIPButtonDelegate,
                                    NSTableViewDataSource, NSTableViewDelegate
{
    // MARK: Public IB Outlet
    @IBOutlet private weak var ibTableView:NSTableView!

    // MARK: Private Member
    private var mUIPheonix:UIPheonix!


    // MARK:- Life Cycle


    override func viewDidLoad()
    {
        super.viewDidLoad()

        initUIPheonix()
        setupWithModels()
        setupTableView()
    }


    // MARK:- NSTableViewDataSource


    func numberOfRows(in tableView:NSTableView) -> Int
    {
        return mUIPheonix.displayModelsCount(forSection:0)
    }


    // MARK: NSTableViewDelegate


    func tableView(_ tableView:NSTableView, viewFor tableColumn:NSTableColumn?, row:Int) -> NSView?
    {
        return mUIPheonix.tableViewCell(forRow:row)
    }


    /**
        Is a delegate function, even if it is a notification handler.
    */
    func tableViewSelectionDidChange(_ notification:Notification)
    {
        if (ibTableView.numberOfSelectedRows > 0)
        {
            ibTableView.deselectRow(ibTableView.selectedRow)
        }
    }


    func tableView(_ tableView:NSTableView, heightOfRow row:Int) -> CGFloat
    {
        return mUIPheonix.tableViewCellHeight(forRow:row)
    }


    func tableView(_ tableView:NSTableView, estimatedHeightForRowAt indexPath:IndexPath) -> CGFloat
    {
        return mUIPheonix.tableViewCellEstimatedHeight(forIndexPath:indexPath)
    }


    // MARK:- UIPButtonDelegate


    func handleAction(forButtonId buttonId:Int)
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


    private func initUIPheonix()
    {
        mUIPheonix = UIPheonix(tableView:ibTableView, delegate:self)
    }


    private func setupWithModels()
    {
        mUIPheonix.setModelViewRelationships(withDictionary:[SimpleButtonModel.nameOfClass:SimpleButtonModelTVCell.nameOfClass,
                                                             SimpleLabelModel2.nameOfClass:SimpleLabelModelTVCell.nameOfClass,
                                                             SimpleUserProfileModel.nameOfClass:SimpleUserProfileModelTVCell.nameOfClass])

        var models = [UIPBaseCellModel]()

        /**
            Illustrate the usage of
            and that both self-sizing cells with constraints
            and the default build-in cells work just fine with auto-layout.
        */

        models.append(SimpleButtonModel(id:ButtonId.helloWorld.rawValue, title:"Hello World!", alignment:SimpleButtonModel.Alignment.center))

        models.append(SimpleLabelModel2(text:"Label #1", backgroundColorHue:0.2))
        models.append(SimpleLabelModel2(text:"Label #2", backgroundColorHue:0.4))
        models.append(SimpleLabelModel2(text:"Label #3", backgroundColorHue:0.6))
        models.append(SimpleLabelModel2(text:"Label #4", backgroundColorHue:0.8))
        
        let simpleUserProfileModel1 = SimpleUserProfileModel(title:"#1 The quick.", description:"Tilde coloring book health.")
        models.append(simpleUserProfileModel1)

        let simpleUserProfileModel2 = SimpleUserProfileModel(title:"#2 The quick, brown fox jumps over a lazy dog.", description:"Tilde coloring book health goth echo park, gentrify semiotics vinyl cardigan quinoa meh master cleanse cray four dollar toast scenester hammock. Butcher truffaut flannel, unicorn fanny pack skateboard pug four loko.")
        models.append(simpleUserProfileModel2)

        mUIPheonix.setDisplayModels(models, forSection:0)
    }


    private func setupTableView()
    {
        ibTableView.delegate = self
        ibTableView.dataSource = self
        ibTableView.gridColor = .lightGray

        /**
            In our demo, we are using mixed custom table view cell types.
            But if we were only using the standard built-in table cell types – this would be enough, because they all have a fixed height of 44 points.


            From Apple documentation:
            The value must be greater than 0.
            Calling -setRowHeight: with a non-pixel aligning (fractional) value will be forced to a pixel aligning (integral) value.
            For variable row height tableViews (ones that have the delegate implement -tableView:heightOfRow:), -rowHeight will be
            used to draw alternating rows past the last row in the tableView.
            The actual -rectOfRow: is equal to the -rowHeight plus the intercellSpacing.height.
            The default value is 17.0 for applications linked on 10.5 and higher (the height acceptable for [NSFont systemFontSize]).
            The default value is 16.0 for 10.4 and lower.

            I.e. enable this code: ibTableView.rowHeight = <some size e.g. 17>
        */
    }
}

