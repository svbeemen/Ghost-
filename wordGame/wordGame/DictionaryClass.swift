//
//  DictionaryClass.swift
//  wordGame
//
//  Created by Sangeeta van Beemen on 16/05/15 W20.
//  Copyright (c) 2015 Sangeeta van Beemen. All rights reserved.
//

import Foundation

class Dictionary
{
    // list containing strings that is the content of the word dictionary
    var filterDictionary: [String]
    
    // is a constant because it never changes
    let fullDictionary: [String]
    
    init(wordList: String)
    {
        self.fullDictionary = wordList.componentsSeparatedByString("\n")
        self.filterDictionary = self.fullDictionary
    }
    
    
    // function that checks letters played and filters the filterDictioanry accordingly
    func filter(lettersToCheck: String)
    {
        self.filterDictionary = self.filterDictionary.filter { $0.hasPrefix(lettersToCheck) }
        println("filterDictionary")
        println(self.filterDictionary)
    }
    
    // function to count amount words in filterDictionary
    func count() -> Int
    {
        return self.filterDictionary.count
    }
    
    // function returns last remaining word in filterDictionary
    func result() -> String
    {
        return self.filterDictionary[0]
    }
    
    // resets filterDictionary to original fullDictionary 
    func reset()
    {
        self.filterDictionary = self.fullDictionary
    }

}