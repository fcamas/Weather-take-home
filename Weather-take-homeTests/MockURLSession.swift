//
//  MockURLSession.swift
//  Weather-take-home
//
//  Created by Fredy on 11/26/24.
//

import Foundation
@testable import Weather_take_home

class MockURLProtocol: URLProtocol {
    static var mockData: Data?
    static var mockResponse: URLResponse?
    static var mockError: Error?
    
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    
    

    override func startLoading() {
        if let error = MockURLProtocol.mockError{
            client?.urlProtocol(self, didFailWithError: error)
        }else if  let data = MockURLProtocol.mockData, let response = MockURLProtocol.mockResponse{
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        }
    }
}

//class MockURLProtocol: URLProtocol {
//    static var mockData: Data?
//    static var mockResponse: URLResponse?
//    static var mockError: Error?
//
//    override class func canInit(with request: URLRequest) -> Bool { true }
//    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
//
//    override func startLoading() {
//        if let error = MockURLProtocol.mockError {
//            client?.urlProtocol(self, didFailWithError: error)
//        } else if let data = MockURLProtocol.mockData, let response = MockURLProtocol.mockResponse {
//            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
//            client?.urlProtocol(self, didLoad: data)
//            client?.urlProtocolDidFinishLoading(self)
//        }
//    }
//    
//    override func stopLoading() {}
//}
