# Trailcutter

A versatile swift link router for matching web links and initializing code
based on what was matched.

## Usage

Basic usage starts with creation of routes

```swift
struct SearchRoute: PathRouteable {
    static let path = "/search/:term"
    let term: String?

    init(routerMatch:RouterMatch) {
        term = routerMatch["term"]
    }
}
```

By marking the `SearchRoute` as `PathRouteable` you're telling the router that
the route can be matched by path. Trailcutter ships with two built in routing
types: `PathRouteable` and `HostRouteable`. Usually `HostRouteable` is used in
conjunction with `PathRouteable` like this:

```swift
struct SearchRoute: PathRouteable, HostRouteable {
    static let path = "/search/:term"
    static let host = "*.mysite.com"
    let term: String?

    init(routerMatch:RouterMatch) {
        term = routerMatch["term"]
    }
}
```

This will make sure that not only does the path match correctly, but also that
the host is correct.

The `RouterMatch` object contains information about the match including the any
matches in the path. The subscript accessor will get any path matchers, or query
params included. For the url `https://www.mysite.com/search/foo?bar=baz` you could
call:
```swift
routerMatch["term"] //=> Optional("foo")
routerMatch["bar"]  //=> Optional("baz")
```

### Building the router

To actually do the routing you build a `RouteSet` object that contains a list of
routes.

```swift
let router = RouteSet(routes:[
  SearchRoute.self,
  BaseRoute.self,
  InboxRoute.self,
])

let route = router.match(url: NSURL(string: "https://www.mysite.com/search/surge+soda"))

if let searchRoute = route as? SearchRoute {
  print("term: \(searchRoute.term)") //=> term: surge+soda
}
```

## TODO

- [ ] Make `RouterMatch` and `RouteSet` easier to extend with new matching rules
- [ ] Remove dependency on `NSURL` for future potential server side use
- [ ] Allow optional path segments
