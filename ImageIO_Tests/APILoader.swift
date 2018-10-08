//
//  DataProcessor.swift
//  ImageIO_Tests
//
//  Created by Viktor Levchenko on 10/4/18.
//  Copyright © 2018 LVA. All rights reserved.
//

import Foundation

protocol APIRequest {
	associatedtype RequestDataType
	associatedtype ResponceDataType
	
	func makeRequest(from data: RequestDataType) throws -> URLRequest
	func parseResponce(data: Data) throws -> ResponceDataType
}

struct APIRequestLoader<T: APIRequest> {
	
	let apiRequest: T
	let urlSession: URLSession
	
	var tableValues: [PointOfInterest]?
	var tableView  : TableView?
	
	init(apiRequest: T, urlSession: URLSession = .shared) {
		self.apiRequest = apiRequest
		self.urlSession = urlSession
	}
	
	func loadAPIRequest(requestData: T.RequestDataType,
						completionHandler: @escaping (T.ResponceDataType?, Error?) -> Void) {
		do {
			let urlRequest = try apiRequest.makeRequest(from: requestData)
			urlSession.dataTask(with: urlRequest) { (data, responce, error) in
				guard let data = data else { return completionHandler(nil, error) }
				do {
					let parseResponce = try self.apiRequest.parseResponce(data: data)
					completionHandler(parseResponce, nil)
				} catch {
					completionHandler(nil, error)
				}
			}.resume()
		} catch { return completionHandler(nil, error) }
	}
	
//	func loadData(near coord: CLLocationCoordinate2D) {
//		let url = URL(string: "/locations?lat=\(coord.latitude)&long=\(coord.longitude)")!
//		URLSession.shared.dataTask(with: url) { (data, response, error) in
//			guard let data = data else { self.handleError(error); return; }
//			do {
//				let values = try JSONDecoder().decode([PointOfInterest].self, from: data)
//
//				DispatchQueue.main.async {
//				//	self.tableValues = values
//					self.tableView?.reloadData()
//				}
//			} catch {
//				self.handleError(error)
//			}
//			}.resume()
//	}
	
	func handleError(_: Error?) {
		
	}
}















