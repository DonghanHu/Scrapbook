//
//  controllerWebKit.swift
//  Scrapbook
//
//  Created by Donghan Hu on 3/9/20.
//  Copyright © 2020 Donghan Hu. All rights reserved.
//

import Cocoa
import WebKit

class controllerWebKit: NSViewController {


    @IBOutlet weak var webkit: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        print("photo path list: ", photonumber.photoPathList)
        let totalNumner = photonumber.photoPathList.count
        
        
        let html = """
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Bootstrap Example</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <style>
        .image-fluid{
            height: 100%;
            widows: 100%;
        }
        #my-grid{
            margin-top: 50px;
            
        }
        .grid-padding{
            padding: 0 8px;
        }
        .grid-padding img:hover{
            box-shadow: 0 10px 40px 0 rgba(0,0,0,0.5);
            transition: 0.8s ease;
        }
    </style>
</head>
<body>

<div class="jumbotron text-center">
  <h1>My First Bootstrap Page</h1>
  <p>Resize this responsive page to see the effect!</p>
</div>
  
<div class="container">

    <br><br><h1 class="text-center text-warning"> Collection View</h1>
    <br><br>
    <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-4 col-12">
            <div class="row"><img src="SKTT1.jpg" class="img-fluid" onclick="openModal();currentSlide(1)">
            </div>
            <br><h5>Title</h5><br>
            <p>Body</p>
            <div class="row"><img src="octopath.jpg" class="img-fluid" onclick="openModal();currentSlide(2)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
            <div class="row"><img src="digi.jpg" class="img-fluid" onclick="openModal();currentSlide(3)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
        </div>
         <div class="col-lg-4 col-md-4 col-sm-4 col-12">
            <div class="row"><img src="octopath.jpg" class="img-fluid" onclick="openModal();currentSlide(4)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
            <div class="row"><img src="latte1.jpg" class="img-fluid" onclick="openModal();currentSlide(5)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
            <div class="row"><img src="SKTT1.jpg" class="img-fluid" onclick="openModal();currentSlide(6)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
        </div>
        
         <div class="col-lg-4 col-md-4 col-sm-4 col-12">
            <div class="row"><img src="puffin.jpg" class="img-fluid" onclick="openModal();currentSlide(7)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
            <div class="row"><img src="SKTT1.jpg" class="img-fluid" onclick="openModal();currentSlide(8)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
            <div class="row"><img src="octopath.jpg" class="img-fluid" onclick="openModal();currentSlide(9)"></div>
            <br><h5>Title</h5><br>
            <p>Body</p>
        </div>
    </div>
    
    
    
</div>


</body>
</html>


"""
       
        webkit.loadHTMLString(html, baseURL: nil)
        // webkit.loadFileURL(<#T##URL: URL##URL#>, allowingReadAccessTo: <#T##URL#>)
    }
    
}
