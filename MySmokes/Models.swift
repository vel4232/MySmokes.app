import Foundation

//Главная_________________________________________________________________

//1 уровень

class FirstLevel {
    var name1: String
    var position1: String
    var website1: String
    var totalrating1: String
    var picture1: String
    var description1: String
    var lines: NSArray

    init?(data: NSDictionary) {
        guard let name1 = data["name"] as? String,
              let position1 = data["position"] as? String,
              let website1 = data["website"] as? String,
              let totalrating1 = data["total rating"] as? String,
              let picture1 = data["picture"] as? String,
              let description1 = data["description"] as? String,
              let lines = data["lines"] as? NSArray else {
            return nil
        }
        self.name1=name1
        self.position1=position1
        self.website1=website1
        self.totalrating1=totalrating1
        self.picture1=picture1
        self.description1=description1
        self.lines=lines
    }
}

//2 уровень

class SecondLevel {
    var line: String
    var flavours: NSArray

    init?(data: NSDictionary) {
        guard let line = data["line"] as? String,
              let flavours = data["flavours"] as? NSArray else {
            return nil
        }
        self.line = line
        self.flavours = flavours
    }
}

//3 уровень

class ThirdLevel {
    var flavour: String
    var hashtag: String
    var totalrating: String
    var myrating: String
    var picture2: String
    var strong: String
    var country: String
    var review: NSArray
    var order: NSArray
    var description: String

    init?(data: NSDictionary) {
        guard let flavour = data["flavour"] as? String,
              let hashtag = data["hashtag"] as? String,
              let totalrating = data["total rating"] as? String,
              let myrating = data["my rating"] as? String,
              let picture2 = data["picture"] as? String,
              let strong = data["strong"] as? String,
              let country = data["country"] as? String,
              let review = data["review"] as? NSArray,
              let order = data["order"] as? NSArray,
              let description = data["description"] as? String else {
            return nil
        }
        self.flavour = flavour
        self.hashtag = hashtag
        self.totalrating = totalrating
        self.myrating = myrating
        self.picture2 = picture2
        self.strong = strong
        self.country = country
        self.review = review
        self.order = order
        self.description = description
    }
}

//4 уровень

//Вес, цена

class FourthLevel {
    var weight: String
    var price: String

    init?(data: NSDictionary) {
        guard let weight = data["weight"] as? String,
              let price = data["price"] as? String else {
            return nil
        }
        self.weight = weight
        self.price = price
    }
}

//Отзывы
class Comments {
    var photo: String
    var data1: String
    var nick: String
    var comment: String

    init?(data: NSDictionary) {
        guard let photo = data["photo"] as? String,
              let data1 = data["data"] as? String,
              let nick = data["nick"] as? String,
              let comment = data["comment"] as? String else {
            return nil
        }
        self.photo = photo
        self.data1 = data1
        self.nick = nick
        self.comment = comment
    }
}

//Профиль_________________________________________________________________

// Главное

class MainMenu {
    var firstname: String
    var secondname: String
    var patronymic: String
    var email: String
    var phonenumber: String
    var gender: String
    var loyalty: String
    var birth: String
    var city: String
    var sending: String
    var picture: String
    var totalpurchases: String
    var address: NSArray
    var stories: NSArray
    var liked: NSArray

    init?(data: NSDictionary) {
        guard let firstname = data["first name"] as? String,
              let secondname = data["second name"] as? String,
              let patronymic = data["patronymic"] as? String,
              let email = data["e-mail"] as? String,
              let phonenumber = data["phone number"] as? String,
              let gender = data["gender"] as? String,
              let loyalty = data["loyalty"] as? String,
              let birth = data["birth"] as? String,
              let city = data["city"] as? String,
              let sending = data["sending"] as? String,
              let picture = data["picture"] as? String,
              let totalpurchases = data["total purchases"] as? String,
              let address = data["address"] as? NSArray,
              let stories = data["stories"] as? NSArray,
              let liked = data["liked"] as? NSArray else {
            return nil
        }
        self.firstname=firstname
        self.secondname=secondname
        self.patronymic=patronymic
        self.email=email
        self.phonenumber=phonenumber
        self.gender=gender
        self.loyalty=loyalty
        self.birth=birth
        self.city=city
        self.sending=sending
        self.picture=picture
        self.totalpurchases=totalpurchases
        self.address = address
        self.stories=stories
        self.liked=liked
    }
}

//Адреса

class Address {
    var city: String
    var street: String
    var streetnumber: String
    var apartmentnumber: String

    init?(data: NSDictionary) {
        guard let city = data["city"] as? String,
              let street = data["street"] as? String,
              let streetnumber = data["streetnumber"] as? String,
              let apartmentnumber = data["apartmentnumber"] as? String else {
            return nil
        }
        self.city=city
        self.street=street
        self.streetnumber=streetnumber
        self.apartmentnumber=apartmentnumber
    }
}

//История

//История 1 уровень

class Story {
    var order: String
    var date: String
    var story: NSArray

    init?(data: NSDictionary) {
        guard let order = data["order"] as? String,
              let date = data["date"] as? String,
              let story = data["story"] as? NSArray else {
            return nil
        }
        self.order=order
        self.date=date
        self.story=story
    }
}

//История 2 уровень

class Story2 {
    var tobacco: String
    var flavour: String
    var picture: String
    var weight: String
    var price: String
    var quantity: String

    init?(data: NSDictionary) {
        guard let tobacco = data["tobacco"] as? String,
              let flavour = data["flavour"] as? String,
              let picture = data["picture"] as? String,
              let weight = data["weight"] as? String,
              let price = data["price"] as? String,
              let quantity = data["quantity"] as? String else {
            return nil
        }
        self.tobacco=tobacco
        self.flavour=flavour
        self.picture=picture
        self.weight = weight
        self.price = price
        self.quantity=quantity
    }
}

//Избранное

//Избранное - 1 уровень

class Liked {
    var kind: String
    var like: NSArray

    init?(data: NSDictionary) {
        guard let kind = data["kind"] as? String,
              let like = data["like"] as? NSArray else {
            return nil
        }
        self.kind=kind
        self.like=like
    }
}

//Избранное - 2 уровень

class Liked2 {
    var name: String
    var hashtag: String
    var picture: String

    init?(data: NSDictionary) {
        guard let name = data["name"] as? String,
              let hashtag = data["hashtag"] as? String,
              let picture = data["picture"] as? String else {
            return nil
        }
        self.name=name
        self.hashtag = hashtag
        self.picture=picture
    }
}
