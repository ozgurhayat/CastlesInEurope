//
//  OnboardingViewModel.swift
//  Castles in Europe
//
//  Created by Ozgur Hayat on 01/12/2020.
//

import Foundation

struct OnboardingViewModel {
    
    private let itemCount: Int
    init(itemCount: Int) {
        self.itemCount = itemCount
    }
    
    func shouldShowGetStartedButton(forIndex index: Int) -> Bool {
        return index == itemCount - 1 ? true: false
    }
}
