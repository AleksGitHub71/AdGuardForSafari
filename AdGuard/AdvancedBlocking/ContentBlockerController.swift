//
//  ContentBlockerController.swift
//  AdvancedBlocking
//
//  Created by Dimitry Kolyshev on 30.01.2019.
//  Copyright © 2019 Adguard Software Ltd. All rights reserved.
//

import Foundation

// How it works:
// Electron stores rules and filters data, but in case electron in not running permanently - we need to store rules data here in extension. For transfering between electron and this extension application we choose some "content-blocker"-like json format. Electron manages to create it and keep up-to-date with user changes. Here we listen for electron messages and update existing local copy.
// This extension injects script to pages from there we handle messages requesting scripts and css to be applied to current page. These scripts and css are selected from saved local json data.

class ContentBlockerController {
    
    private var contentBlockerContainer: ContentBlockerContainer;
    
    // Constructor
    init() {
        // TODO: Keep content-blocker json up-to-date
        
        contentBlockerContainer = ContentBlockerContainer();
        
        // TODO: Request content-blocker json from electron
        let contentBlockerJsonString = """
            [
                {
                    "trigger": {
                        "url-filter": ".*",
                        "if-domain": [
                            "example.com"
                        ]
                    },
                    "action": {
                        "type": "script",
                        "script": "included-script"
                    }
                },
                {
                    "trigger": {
                        "url-filter": ".*",
                        "if-domain": [
                            "webkit.org"
                        ]
                    },
                    "action": {
                        "type": "css",
                        "css": "#included-css:has(div) { height: 5px; }"
                    }
                }
            ]
        """;
        
        contentBlockerContainer.setJson(json: contentBlockerJsonString);
    }
    
    // Returns requested scripts and css for specified url
    func getData(url: URL?) -> String {
        let data: ContentBlockerContainer.BlockerData = contentBlockerContainer.getData(url: url) as! ContentBlockerContainer.BlockerData;
        return data.toString();
    }
}
