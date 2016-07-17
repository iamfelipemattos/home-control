//
//  HomeModel.swift
//  HomeControl
//
//  Created by Felipe Mattos at Venturus4Tech course.
//

import Foundation

class HomeModel {

    var temperatureValue:Float  = 0;
    var time:String             = "";
    var date:String             = "";

    init(temperatureValue:Float, time:String, date:String){
        self.temperatureValue = temperatureValue;
        self.time = time;
        self.date = date;
    }

}
