//
//  dictionaryClass.swift
//  Ghost
//
//  Created by Sangeeta van Beemen on 20/04/15 W18.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class Dictionary
{
    // declare array for whole dictionary and one for the word check list
    var dictionaryWordList = [String]()
    var checkWordList = [String]()

    // load dictionary into an array of strings
    // load dictionary into filter list to start with
    init(words:String)
    {
        self.dictionaryWordList = words.componentsSeparatedByString("\n")
        self.checkWordList = self.dictionaryWordList
    }
    
    func filter(playedLetters:String)
    {
        self.checkWordList = self.dictionaryWordList.filter { $0.hasPrefix(playedLetters) }
    }
    
    func count() -> Int
    {
        return self.checkWordList.count
    }
    
    func result() -> String?
    {

        return self.checkWordList[0]
    }
    
    func reset()
    {
        self.checkWordList = self.dictionaryWordList
    }

}
