//
//  Constants.swift
//  Youtube_App_Build
//
//  Created by Thien Tung on 7/4/20.
//  Copyright © 2020 Thien Tung. All rights reserved.
//

import Foundation

struct Constants {
    static var API_KEY = "AIzaSyCypIp-ncBP43zzp2U72gy0cTjE2SMZiAo"
    static var PLAYLIST_ID = "PLAhmD05dUEfrW-zcQr9aFHYqsmb5hSAqy"
    static var API_URL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
}
