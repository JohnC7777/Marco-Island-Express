//
//  MkMapRect.swift
//  Marco Island Express
//
//  Created by United States MO on 1/19/24.
//
import SwiftUI
import MapKit

extension MKMapRect {
    func moveMapRect() -> MKMapRect {
        let widthPadding = self.size.width * 0.25
        let heightPadding = self.size.height * 0.25

        let newWidth = widthPadding + self.size.width
        let newHeight = heightPadding + self.size.height

        let newOriginX = self.origin.x - (widthPadding/2)
        let newOriginY = self.origin.y - (heightPadding/2) + 161000
        
        return MKMapRect(x: newOriginX, y: newOriginY, width: newWidth, height: newHeight)
    }
}
