//
//  BurgerPlate.swift
//
//  Created by Kevin Csiffary
//  Created on 2024-03-22
//  Version 1.0
//  Copyright (c) 2024 Kevin Csiffary. All rights reserved.
//
//  Calculates the amount of burgers you fit on your triangle shaped plate.
//  Then the cost of those burgers and type of triangle the plate is.

import Foundation

// Creates enum for errors.
enum InputError: Error {
    case nonNumber
}

// Initialize variables
let BURGER1SIZE: Double = 8.7
let BURGER2SIZE: Double = 10.3
let BURGER1COST: Double = 5.99
let BURGER2COST: Double = 7.25
let PLATESIDELENGTH: Double = 35.0
let HST: Double = 1.13
let TOTALINNERTRIANGLEANGLE: Int = 180

print("This program asks you two angles of your plate,", terminator: "")
print("and the size of your burger, then tells you the ", terminator: "")
print("type of triangle your plate is and how many ", terminator: "")
print("burgers can fit (based on area) and how much they will cost.")
print("*Assumed side length between angles is 35cm\n")

var quit = false

repeat {
    do {
        print("What is the first angle of your plate?")
        guard let angle1 = Double(readLine() ?? "") else {
            throw InputError.nonNumber
        }
        print("What is the second angle of your plate?")
        guard let angle2 = Double(readLine() ?? "") else {
            throw InputError.nonNumber
        }
        print("Please enter the size of your burger, 1 or 2.")
        guard let burgerSize = Int(readLine() ?? "") else {
            throw InputError.nonNumber
        }

        let angle3 = getThirdAngle(angle1, angle2)

        if angle3 > 0 {
            var burgerCount = 0
            var subtotal = 0.0
            var total = 0.0
            var triangleType = ""

            if burgerSize == 1 {
                let burgerArea = getBurgerArea(BURGER1SIZE)
                let triangleArea = calculateTriArea(angle1, angle2, angle3)
                burgerCount = getBurgerCount(burgerArea, triangleArea)
                subtotal = Double(burgerCount) * BURGER1COST
                total = subtotal * HST
                triangleType = calculateTriangleType(angle1, angle2, angle3)
            } else if burgerSize == 2 {
                let burgerArea = getBurgerArea(BURGER2SIZE)
                let triangleArea = calculateTriArea(angle1, angle2, angle3)
                burgerCount = getBurgerCount(burgerArea, triangleArea)
                subtotal = Double(burgerCount) * BURGER2COST
                total = subtotal * HST
                triangleType = calculateTriangleType(angle1, angle2, angle3)
            } else {
                print("That is not an available size!")
                continue
            }

            print("You can fit \(burgerCount) size \(burgerSize) burger(s) on your \(triangleType) shaped plate.")
            print("Your subtotal will be $\(String(format: "%.2f", subtotal))")
            print("and your total will be $\(String(format: "%.2f", total))")

        } else {
            print("Your triangle is not real!")
            continue
        }

        print("\nWould you like to try again?")
        print("Enter q to quit")
        guard let userQuit = readLine() else {
            throw InputError.nonNumber
        }

        if userQuit == "q" {
            quit = true
        }

    } catch {
        print("Please enter a proper number!\n")
        continue
    }
} while !quit

func getThirdAngle(_ angle1: Double, _ angle2: Double) -> Double {
    return Double(TOTAL_INNER_TRIANGLE_ANGLE - Int(angle1) - Int(angle2))
}

func calculateTriangleType(_ angle1: Double, _ angle2: Double, _ angle3: Double) -> String {
    if angle1 == angle2 && angle2 == angle3 {
        return "Equilateral"
    } else if angle1 == angle2 || angle2 == angle3 || angle1 == angle3 {
        return "Isosceles"
    } else {
        return "Scalene"
    }

func calculateTriArea(_ angle1: Double, _ angle2: Double, _ angle3: Double) -> Double {
    let sinLaw = sin(angle3) / PLATE_SIDE_LENGTH
    let secondSide = sin(angle1) / sinLaw
    let height = sin(angle2) * secondSide
    return abs((PLATE_SIDE_LENGTH * height) / 2)
}

func getBurgerArea(_ burgerDiameter: Double) -> Double {
    return Double.pi * pow((burgerDiameter / 2), 2)
}

func getBurgerCount(_ burgerArea: Double, _ plateArea: Double) -> Int {
    return Int(plateArea / burgerArea)
}
