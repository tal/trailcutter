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
params included. For the url `https://www.mysite.com/search/foo?bar=baz` you
could call:
```swift
routerMatch["term"] //=> Optional("foo")
routerMatch["bar"]  //=> Optional("baz")
```

### Building the router

To actually do the routing you build a `RouteSet` object that contains a list of
routes.

```swift
struct SearchRoute: PathRouteable, HostRouteable {
    static let path = "/search/:term"
    static let host = "*.mysite.com"
    let term: String?

    init(routerMatch:RouterMatch) {
        term = routerMatch["term"]
    }

    var viewController: UIViewController {
      return SearchViewController(term: term)
    }
}

let router = RouteSet(routes:[
  SearchRoute.self,
  BaseRoute.self,
  InboxRoute.self,
])

let route = router.match(url: NSURL(string: "https://www.mysite.com/search/surge+soda"))

if let searchRoute = route as? SearchRoute {
  print("term: \(searchRoute.term)") //=> term: surge+soda
  self.navigationController.pushViewController(searchRoute.viewController, animated: true)
}
```

This allows you to make a generically useable routes. For instance making a
protocol which enforces the return of a view controller that's blindly pushed
onto the stack when matched.

Optionally you could even apply the protocols directly to the view controller
you want and just do `if let vc = route as? UIViewController { push route }`.
I wouldn't recommend this as it violates separation of concerns, but it's possible.

### All `Routeable`s

- [`PathRouteable`](https://github.com/tal/trailcutter/blob/master/Trailcutter/PathRouteable.swift)
Allows routing based on path. Path fragments can be extracted as parameters
- [`HostRouteable`](https://github.com/tal/trailcutter/blob/master/Trailcutter/HostRouteable.swift)
Allows routing based on host or wildcards for hosts. You can preifix any
host with `*` to allow suffix matching.
-  [`SchemeRouteable`](https://github.com/tal/trailcutter/blob/master/Trailcutter/SchemeRouteable.swift)
Matches based on scheme. This can be for either custom schemes based on your app
name, or `http`/`https`
-  [`URIRouteable`](https://github.com/tal/trailcutter/blob/master/Trailcutter/URIRouteable.swift)
This matches based on the full URI. Is an amalgamation of all of them. Splits the
uri into its segments and then matches each independently.

### Reverse routing

Path and URI routes can create routes based on parameters in the reverse fashion
to actual routing. For the given routes:

```swift
struct SearchRoute: PathRouteable {
    static let path = "/search/:term"
    let term: String?

    init(routerMatch:RouterMatch) {
        term = routerMatch["term"]
    }
}

struct PostRoute: PathRouteable {
    static let uri = "https://*.mysite.com/post/:id"
    let id: String?

    init(routerMatch:RouterMatch) {
        id = routerMatch["id"]
    }
}
```

you can do the following to generate string representations:

```swift
let surgePath: String = SearchRoute.pathFromParams(["term": "surge", "sort": "score desc"])
surgePath //=> "/search/surge?sort=score%20desc"

let postURI: String = PostRoute.uriFromParams(["id": "1234"], overrideHost: "subdomain.mysite.com")
postURI //=> "https://subdomain.mysite.com/post/1234"
```

## TODO

- [ ] Make `RouterMatch` and `RouteSet` easier to extend with new matching rules
- [ ] Remove dependency on `NSURL` for future potential server side use
- [ ] Allow optional path segments
- [ ] Allow optional characters or segments in schemes (`http` vs `https`)
- [ ] Test URI matching performance and see if improvement is needed
