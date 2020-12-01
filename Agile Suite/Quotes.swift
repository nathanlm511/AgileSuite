//
//  Quotes.swift
//  Agile Suite
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import SwiftUI

struct Quotes: View {
    var body: some View {
        List {
            ForEach(quotesFound, id: \.self)
            { quote in
                VStack {
                    Text(quote.quote)
                    Text(quote.author)
                }
            }
           
        }
    }
}

struct Quotes_Previews: PreviewProvider {
    static var previews: some View {
        Quotes()
    }
}
