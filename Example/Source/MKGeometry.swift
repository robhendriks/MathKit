//
//  MKGeometry.swift
//  macOS Example
//
//  Created by Rob Hendriks on 18/01/2017.
//  Copyright © 2017 Rob Hendriks. All rights reserved.
//

import MathKit
import Cocoa

struct MKGeometry {
    
    private(set) public var faces: [[Int]]
    private(set) public var matrix: Matrix
    private(set) public var colors = [Int: NSColor]()
    
    public init(_ vertices: [Vector], _ faces: [[Int]], _ colors: [Int: NSColor]) {
        self.faces = faces
        self.colors = colors
        
        matrix = Matrix(4, vertices.count)
        
        for i in 0..<vertices.count {
            matrix[i, 0] = vertices[i].x
            matrix[i, 1] = vertices[i].y
            matrix[i, 2] = vertices[i].z
            matrix[i, 3] = 1
        }
    }
    
    public static func fromFile(_ path: String) -> MKGeometry? {
        do {
            let data = try String(contentsOfFile: path)
            return parse(data.components(separatedBy: .newlines))
        } catch {
            print(error)
        }
        return nil
    }
    
    public static func parse(_ lines: [String]) -> MKGeometry? {
        var vertices = [Vector]()
        var faces = [[Int]]()
        var colors = [Int: NSColor]()
        
        for line in lines {
            if line.isEmpty {
                continue
            }
            
            let parts = line.components(separatedBy: " ")
            
            if parts.count < 2 {
                continue
            } else if parts.count == 4 && parts[0] == "v" {
                vertices.append(Vector(Double(parts[1])!, Double(parts[2])!, Double(parts[3])!))
            } else if parts.count >= 4 && parts[0] == "f" {
                var face = [Int]()
                
                for i in 1..<parts.count {
                    let part = parts[i]
                    let index = part.index(part.startIndex, offsetBy: 1)
                    let str = part.substring(from: index)
                    
                    face.append(Int(str)! - 1)
                }
                
                faces.append(face)
            } else if parts.count == 6 && parts[0] == "c" {
                let part = parts[1]
                let index = part.index(part.startIndex, offsetBy: 1)
                let str = part.substring(from: index)

                let r = Double(parts[2])!
                let g = Double(parts[3])!
                let b = Double(parts[4])!
                let a = Double(parts[5])!
                
                let color = NSColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
                
                colors[Int(str)! - 1] = color
            }
        }
        
        return MKGeometry(vertices, faces, colors)
    }
}
