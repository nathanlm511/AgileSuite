//
//  QuoteApiData.swift
//  Agile Suite
//
//  Created by CS3714 on 12/1/20.
//  Copyright © 2020 Nathan Moeliono, Tommy Phan, Mariam Naseem. All rights reserved.
//

import Foundation
import SwiftUI
 
// Declare quotesFound as a global mutable variable accessible in all Swift files
var quotesFound: [Quote] = []
 
/*
====================================
MARK: - Obtain Quote Data from API
====================================
*/
public func obtainQuoteDataFromApi() {
   
    // Initialization
    quotesFound = []
 
    /*
     *************************
     *   API Documentation   *
     *************************
 
     This API does not require an API key.
    
     https://quotes.rest/qod?language=en
    
     JSON response when searching:
     {
       "success": {
         "total": 1
       },
       "contents": {
         "quotes": [
           {
             "quote": "The best way to predict the future is to create it.",
             "length": "51",
             "author": "Abraham Lincoln",
             "tags": [
               "future",
               "inspire"
             ],
             "category": "inspire",
             "language": "en",
             "date": "2020-12-01",
             "permalink": "https://theysaidso.com/quote/abraham-lincoln-the-best-way-to-predict-the-future-is-to-create-it",
             "id": "Q3TIEXJ5M0DTgVJkdShQpAeF",
             "background": "https://theysaidso.com/img/qod/qod-inspire.jpg",
             "title": "Inspiring Quote of the day"
           }
         ]
       },
       "baseurl": "https://theysaidso.com",
       "copyright": {
         "year": 2022,
         "url": "https://theysaidso.com"
       }
     }
     */
   
    /*
     *********************************************
     *   Obtaining API Search Query URL Struct   *
     *********************************************
     */
   
    let apiUrl = "https://quotes.rest/qod?language=en"
    
    /*
     searchQuery may include unrecognizable foreign characters inputted by the user,
     e.g., Côte d'Ivoire, that can prevent the creation of a URL struct from the
     given apiUrl string. Therefore, we must test it as an Optional.
    */
    var apiQueryUrlStruct: URL?
   
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        // quotesFound will have the initial values set as above
        return
    }
 
    /*
    *******************************
    *   HTTP GET Request Set Up   *
    *******************************
    */
   
    let headers = [
        "accept": "application/json",
        "cache-control": "no-cache",
        "connection": "keep-alive",
        "host": "quotes.rest"
    ]
 
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
 
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
 
    /*
    *********************************************************************
    *  Setting Up a URL Session to Fetch the JSON File from the API     *
    *  in an Asynchronous Manner and Processing the Received JSON File  *
    *********************************************************************
    */
   
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
 
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the JSON file from the API is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
 
        // Process input parameter 'error'
        guard error == nil else {
            // quotesFound will have the initial values set as above
            semaphore.signal()
            return
        }
       
        /*
         ---------------------------------------------------------
         🔴 Any 'return' used within the completionHandler Closure
            exits the Closure; not the public function it is in.
         ---------------------------------------------------------
         */
        
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            // quotesFound will have the initial values set as above
            semaphore.signal()
            return
        }
 
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            // quotesFound will have the initial values set as above
            semaphore.signal()
            return
        }
 
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
                               options: JSONSerialization.ReadingOptions.mutableContainers)
 
            /*
             JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
             Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
             where Dictionary Key type is String and Value type is Any (instance of any type)
             */
            var quoteDataDictionary = Dictionary<String, Any>()   // Or [String: Any]()
            
            /*
             https://quotes.rest/qod?language=en
             Returns an JSON Object
             */
            if let outerJson = jsonResponse as? [String: Any] {
                if let innerJson = outerJson["contents"] as? [String: Any] {
                    if let jsonArray = innerJson["quotes"] as? [Any] {
                        for index in 1...jsonArray.count {
                            if let jsonObject = jsonArray[index - 1] as? [String: Any] {
                                quoteDataDictionary = jsonObject
                                
                                //----------------
                                // Initializations
                                //----------------
                               
                                var quote = "", author = ""
                               
                                //--------------------
                                // Obtain Quote
                                //--------------------
                     
                                // "quote": "The best way to predict the future is to create it."
                                if let quoteData = quoteDataDictionary["quote"] as? String {
                                    quote = quoteData
                                } else {
                                    // quotesFound will have the initial values as set above
                                    semaphore.signal()
                                    return
                                }
                     
                                //--------------------------
                                // Obtain Author
                                //--------------------------
                     
                                // "author": "Abraham Lincoln"
                                if let authorData = quoteDataDictionary["author"] as? String {
                                    author = authorData
                                }
                                
                                //----------------------------------------------------------
                                // Construct a New Quote Struct and Set it to quotesFound
                                //----------------------------------------------------------
                               
                                quotesFound.append(Quote(quote: quote, author: author))
                            }
                        }
                    }
                }
            } else {
                // quotesFound will have the initial values set as above
                semaphore.signal()
                return
            }
 
        } catch {
            // quotesFound will have the initial values set as above
            semaphore.signal()
            return
        }
        semaphore.signal()
    }).resume()
 
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
 
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
    */
 
    _ = semaphore.wait(timeout: .now() + 10)
    
    if quotesFound.count < 1 {
        quotesFound.append(Quote(quote: "The way to get started is to quit talking and begin doing", author: "Walt Disney"))
    }
 
}
