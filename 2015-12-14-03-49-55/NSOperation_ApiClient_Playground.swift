import Foundation
import XCPlayground

class ImageDownloader: NSOperation {
    let imageId: String
    var data: String?
    
    init(imageId: String) {
        self.imageId = imageId
    }
    
    override func main() {
        if self.cancelled {
            return
        }
        
        sleep(5)
        
        if self.cancelled {
            return
        }
        
        self.data = "Downloaded Image"
    }
}

class ApiClient {
    func getImage(imageId: String) -> ImageDownloader {
        return ImageDownloader(imageId: imageId)
    }
}

func exampleUiClient() {
    print("Start function")
    
    let queue = NSOperationQueue()
    let apiClient = ApiClient()
    let imageId = "123"
    
    let imageDownloader = apiClient.getImage(imageId)
    
    imageDownloader.completionBlock = {
        print("In closure.")
        print("Downloading of image with id \(imageId) complete")
        print("Image data is \(imageDownloader.data)")
        print("Finish closure")
    }
    
    queue.addOperation(imageDownloader)
    
    print("Complete function")
}

exampleUiClient()
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

/*
 * Prints:
 * Start function
 * Complete function
 * In closure.
 * Downloading of image with id 123 complete
 * Image data is Optional("Downloaded Image")
 * Finish closure
 */
