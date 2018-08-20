//
//  ViewController.swift
//  SmartWindows
//
//  Created by Koh Yi Zhi Elliot - Ezekiel on 17/5/18.
//  Copyright © 2018 Kohbroco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var windowWidth : CGFloat = 60
    var windowGap : CGFloat = 5
    var gridSize : CGFloat = 5
    
    var moves = 0
    
    var history = [(Int,Int)]()
    
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var winView: UIView!
    @IBOutlet weak var gameView: UIView!
    private var tiles = [Tile]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        BuildWindows()
        
    }
    
    func BuildWindows()
    {
        let hor_offset = Sizing.ScreenWidth()/2 - (windowWidth + windowGap)*gridSize/2
        let vert_offset = Sizing.ScreenHeight()/2 - (windowWidth + windowGap)*gridSize/2
        
        for x in 0..<Int(gridSize)
        {
            for y in 0..<Int(self.gridSize)
            {
                let size = CGRect(x:hor_offset + CGFloat(x)*(windowWidth+windowGap), y: vert_offset + CGFloat(y)*(windowWidth+windowGap), width: windowWidth, height: windowWidth)
                let tile = Tile(frame: size)
                tile.backgroundColor = UIColor.gray
                tile.addTarget(self, action: #selector(TileSelected(tile:)), for: .touchUpInside)
                tile.coordinate = (x,y)
//                tile.setTitle("\(tile.coordinate)", for: .normal)
                tiles.append(tile)
                self.gameView.addSubview(tile)
            }
        }
        
        for tile in tiles
        {
            if randomBool()
            {
                tile.Swap()
            }
        }
    }
    
    func randomBool() -> Bool {
        return arc4random_uniform(2) == 0
    }
    @IBAction func UndoPressed(_ sender: Any) {
        if history.count == 0
        {
            return
        }
        
        if let tile = TileWithIndex(history[0])
        {
            SwapTiles(center: tile)
            history.removeFirst()
        }
    }
    
    @objc private func TileSelected(tile : Tile)
    {
        //history
        history.insert(tile.coordinate, at: 0)
        if history.count > 30
        {
            history.popLast()
        }
        
        
        moves = moves + 1
        UpdateMovesLabel()
        
        SwapTiles(center: tile)
        
        if Win()
        {
            winView.alpha = 1
        }
    }
    
    func SwapTiles(center : Tile)
    {
        center.Swap()
        
        let offsets = [(0,1),(0,-1),(1,0),(-1,0)]
        
        for offset in offsets
        {
            let tile = TileWithIndex((center.coordinate.0 + offset.0,(center.coordinate.1 + offset.1)))
            tile?.Swap()
        }
        
        if Win()
        {
            winView.alpha = 1
        }
    }
    
    func UpdateMovesLabel()
    {
        self.movesLabel.text = "MOVES: \(moves)"
    }
    
    @IBAction func ButtonClicked(_ sender: Any) {
        ResetGame()
    }
    func ResetGame()
    {
        moves = 0
        UpdateMovesLabel()
        
        for tile in tiles
        {
            tile.ForceOpen()
            
            if randomBool()
            {
                tile.Swap()
            }
        }
        
        winView.alpha = 0
        
        history.removeAll()
        
        
    }
    
    func Win() -> Bool
    {
        var counter = 0
        for tile in tiles
        {
            if tile.isOpen == false
            {
                counter = counter + 1
            }
        }
        
        
        if counter == 0 || counter == tiles.count
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    private func TileWithIndex(_ coord : (Int,Int)) -> Tile?
    {
        for tile in tiles
        {
            if tile.coordinate == coord
            {
                return tile
            }
        }
        
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

