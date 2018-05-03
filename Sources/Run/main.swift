import Vapor
import VaporPostgreSQL

let drop = Droplet()
drop.preparations += Blogpost.self


do {
    try drop.addProvider(VaporPostgreSQL.Provider.self)
} catch {
    assertionFailure("Error adding provider: \(error)")
}

/*drop.get {
    req in 
    var blogpost = Blogpost(title: "Hello", body: "World")
    try blogpost.save()
    return try blogpost.makeJSON()
}*/

drop.get { req in
    return try drop.view.make("new")
}

drop.post("submit") { req in
    guard let title = req.formURLEncoded?["title"]?.string,
        let body = req.formURLEncoded?["body"]?.string
        else {
            return "Missing Fields"
        }
    
    var blogpost = Blogpost(title: title, body: body)
    try blogpost.save()
    
    return try blogpost.makeJSON()
}

drop.get("blogposts") { req in
    let blogposts = try Blogpost.query().all()
    return try drop.view.make("blogposts", ["blogposts": blogposts.makeNode()])
    
    //return try blogposts.makeJSON()
}

drop.get("blogposts", Int.self) { req, blogId in
    guard let blog = try Blogpost.query().filter("id", blogId).first()
        else {
            return "No Blog Found"
        }
    
    return try blog.makeJSON()
}

drop.run()