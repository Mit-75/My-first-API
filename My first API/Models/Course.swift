//
//  Course.swift
//  My first API
//
//  Created by Dmitry Parhomenko on 05.02.2024.
//

import Foundation

struct Course: Decodable {
    let name: String
    let imageUrl: URL
    let number_of_lessons: Int
    let number_of_tests: Int
}
