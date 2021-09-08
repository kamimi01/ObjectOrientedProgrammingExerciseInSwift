import Foundation

class Drink {
    static let coke = 0
    static let dietCoke = 1
    static let tea = 2

    private let kind: Int

    init(kind: Int) {
        self.kind = kind
    }

    func getKind() -> Int {
        return kind
    }
}

class VendingMachine {
    var quantityOfCoke = 5
    var quantityOfDietCoke = 5
    var quantityOfTea = 5
    var numberOf100Yen = 10
    var charge = 0

    /// ジュースを購入する
    /// - Parameters:
    ///   - i: 投入金額. 100円と500円のみ受け付ける.
    ///   - kindOfDrink: ジュースの種類.
    /// - Returns: 指定したジュース. 在庫不足や釣り銭不足で買えなかった場合は nil が返される.
    func buy(i: Int, kindOfDrink: Int) -> Drink? {
        // 100円と500円だけ受け付ける
        if (i != 100) && (i != 500) {
            charge += i
            return nil
        }
        
        if (kindOfDrink == Drink.coke) && (quantityOfCoke == 0) {
            charge += i
            return nil
        } else if (kindOfDrink == Drink.dietCoke) && (quantityOfDietCoke == 0) {
            charge += i
            return nil
        } else if (kindOfDrink == Drink.tea) && (quantityOfTea == 0) {
            charge += i
            return nil
        }
        
        // 釣り銭不足
        if i == 500 && numberOf100Yen < 4 {
            charge += i
            return nil
        }
        
        if i == 100 {
            // 100円を釣り銭に変える
            numberOf100Yen += 1
        } else if i == 500 {
            // 400円のお釣り
            charge += (i - 100)
            // 100円の釣り銭に変える
            numberOf100Yen -= (i - 100) / 100
        }
        
        if kindOfDrink == Drink.coke {
            quantityOfCoke -= 1
        } else if kindOfDrink == Drink.dietCoke {
            quantityOfDietCoke -= 1
        } else {
            quantityOfTea -= 1
        }
        
        return Drink(kind: kindOfDrink)
    }
}
