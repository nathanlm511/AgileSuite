//
//  Game.swift
//  Agile Suite
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import SwiftUI


struct Game: View {
    /*
     
     CGSize is a structure that is sometimes used to represent a distance vector,
     as used herein, rather than a physical size. As a vector, its values can be negative.
     The value .zero defines the size whose width and height are both zero.
     */
    @State private var currentPosition1:    CGSize = .zero
    @State private var newPosition1:        CGSize = .zero
    @State private var currentPositionHole: CGSize = CGSize(width:  (CGFloat)((Int)(arc4random() % UInt32(300)) - 150), height: (CGFloat)(arc4random() % UInt32(400) + 50))
    
    let delta: CGFloat = 30
    
    var body: some View {
        VStack {
            Text("Get the apple inside the hole!")
            ZStack(alignment: .leading) {
                AnyView(Hole)
                AnyView(Rectangle1)
            }
        }
    }
    
    /*
    ----------------------------
    MARK: - Rectangle1
    ----------------------------
    */
    var Rectangle1: some View {
        return AnyView(
            Rectangle()
                .fill(Color.red)
                .frame(width: 20, height: 20)
                /*
                 Since currentPosition1 width and height are both zero initially,
                 puzzlePieceImage1 is placed at the center point of the iPad screen.
                 */
                .offset(x: self.currentPosition1.width, y: self.currentPosition1.height)
               
                .gesture(DragGesture()
                    .onChanged { value in
                        self.currentPosition1 = CGSize(width: value.translation.width + self.newPosition1.width, height: value.translation.height + self.newPosition1.height)
                }
                .onEnded { value in
                    self.currentPosition1 = CGSize(width: value.translation.width + self.newPosition1.width, height: value.translation.height + self.newPosition1.height)
                    self.newPosition1 = self.currentPosition1
                    
                    if self.currentPosition1.width  > (currentPositionHole.width - delta) &&
                       self.currentPosition1.width  < (currentPositionHole.width + delta) &&
                       self.currentPosition1.height > (currentPositionHole.height - delta) &&
                       self.currentPosition1.height < (currentPositionHole.height + delta)
                    {
                        currentPositionHole = CGSize(width:  (CGFloat)((Int)(arc4random() % UInt32(300)) - 150), height: (CGFloat)(arc4random() % UInt32(400) + 50))
                        
                        self.newPosition1 = .zero
                        self.currentPosition1 = .zero
                    }
                }
            )   // End of gesture
        )   // End of AnyView
    }   // End of var
    
    /*
    ----------------------------
    MARK: - Hole
    ----------------------------
    */
    var Hole: some View {
        return AnyView(
            Rectangle()
                .fill(Color.black)
                .frame(width: 50, height: 50)
                /*
                 Since currentPosition1 width and height are both zero initially,
                 puzzlePieceImage1 is placed at the center point of the iPad screen.
                 */
                .offset(x: self.currentPositionHole.width, y: self.currentPositionHole.height)
        )   // End of AnyView
    }   // End of var
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game()
    }
}


