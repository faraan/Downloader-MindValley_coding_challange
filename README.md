
Downloader is a lightweight *generic* cache for iOS and tvOS written in Swift 5. It's designed to be super-simple to use. Here's how you would initalize a JSON cache and fetch objects from a url:

```swift
let cache = Cache<JSON>(name: "github")
let URL = NSURL(string: "https://api.github.com/users/Downloader")!

cache.fetch(URL: URL).onSuccess { JSON in
    print(JSON.dictionary?["bio"])
}
```

Downloader provides a memory cache for `UIImage`, `NSData`, `JSON`, `String` or any other type that can be read or written as data.

Particularly, Downloader excels at working with images. It includes a zero-config image cache with automatic resizing. Everything is done in background, allowing for fast, responsive scrolling. Asking Downloader to load, resize, cache and display an *appropriately sized image* is as simple as:

```swift
imageView.hnk_setImageFromURL(url)
```

## Features

* Generic cache with out-of-the-box support for `UIImage`, `NSData`, `JSON` and `String`
* First-level memory cache using `NSCache`
* Asynchronous [fetching](#fetchers) of original values from network or disk
* All disk access is performed in background
* Thread-safe
* Automatic cache eviction on memory warnings or disk capacity reached
* Comprehensive unit tests
* Extensible by defining [custom formats](#formats), supporting [additional types](#supporting-additional-types) or implementing [custom fetchers](#custom-fetchers)

For images:

* Zero-config `UIImageView` and `UIButton` extensions to use the cache, optimized for `UITableView` and `UICollectionView` cell reuse
* Background image resizing and decompression


Installtion:
Very simple , just drag Downloader Source folder to your project.


## Using the cache

Downloader provides shared caches for `UIImage`, `NSData`, `JSON` and `String`. You can also create your own caches. 

The cache is a key-value store. For example, here's how you would cache and then fetch some data.

```Swift
let cache = Shared.dataCache
        
cache.set(value: data, key: "some_audio.mp4")
        
// Eventually...

cache.fetch(key: "some_audio.mp4").onSuccess { data in
    // Do something with data
}
```

In most cases the value will not be readily available and will have to be fetched from network or disk. Downloader offers convenience `fetch` functions for these cases. Let's go back to the first example, now using a shared cache: 

```Swift
let cache = Shared.JSONCache
let URL = NSURL(string: "https://some-url.com")!
    
cache.fetch(URL: URL).onSuccess { JSON in
   print(JSON.dictionary?["key"])
}
```

## Simple downloading for images with just a single line

Need to cache and display images? Downloader provides convenience methods for `UIImageView` and `UIButton` with optimizations for `UITableView` and `UICollectionView` cell reuse. Images will be resized appropriately and cached in a shared cache.

```swift
// Setting a remote image
imageView.hnk_setImageFromURL(url)

```

## Fetchers

The `fetch` functions for urls and paths are actually convenience methods. Under the hood Downloader uses fetcher objects. To illustrate, here's another way of fetching from a url by explictly using a network fetcher:

```swift
let URL = NSURL(string: "http://some_url.com/icon.png")!
let fetcher = NetworkFetcher<UIImage>(URL: URL)
cache.fetch(fetcher: fetcher).onSuccess { image in
    // Do something with image
}
```

Fetching an original value from network or disk is an expensive operation. Fetchers act as a proxy for the value, and allow Downloader to perform the fetch operation only if absolutely necessary.

In the above example the fetcher will be executed only if there is no value associated with `"http://some_url.com/icon.png"` in the memory. If that happens, the fetcher will be responsible from fetching the original value, which will then be cached to avoid further network activity.

Downloader provides two specialized fetchers: `NetworkFetcher<T>` and `DiskFetcher<T>`. You can also implement your own fetchers by subclassing `Fetcher<T>`.

### Custom fetchers

Through custom fetchers you can fetch original values from other sources than network or disk (e.g., Core Data), or even change how Downloader acceses network or disk (e.g., use [Alamofire](https://github.com/Alamofire/Alamofire) for networking instead of `NSURLSession`). A custom fetcher must subclass `Fetcher<T>` and is responsible for:

* Providing the key (e.g., `NSURL.absoluteString` in the case of `NetworkFetcher`) associated with the value to be fetched
* Fetching the value in background and calling the success or failure closure accordingly, both in the main queue
* Cancelling the fetch on demand, if possible

Fetchers are generic, and the only restriction on their type is that it must implement `DataConvertible`. 

## Supporting additional types

Downloader can cache any type that can be read and saved as data. This is indicated to Downloader by implementing the protocols `DataConvertible` and `DataRepresentable`.

```Swift
public protocol DataConvertible {
    typealias Result
    
    class func convertFromData(data:NSData) -> Result?
    
}

public protocol DataRepresentable {
    
    func asData() -> NSData!
    
}
```

This is how one could add support for `NSDictionary`:

```Swift
extension NSDictionary : DataConvertible, DataRepresentable {
    
    public typealias Result = NSDictionary
    
    public class func convertFromData(data:NSData) -> Result? {
        return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? NSDictionary
    }
    
    public func asData() -> NSData! {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
}
```

