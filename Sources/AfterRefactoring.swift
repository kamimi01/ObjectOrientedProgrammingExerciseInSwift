import Foundation

class Drink2 {
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

class VendingMachine2 {
    var quantityOfCoke = 5
    var quantityOfDietCoke = 5
    var quantityOfTea = 5
    var numberOf100Yen = 10
    var charge = 0

    /// ジュースを購入する
    /// - Parameters:
    ///   - payment: 投入金額. 100円と500円のみ受け付ける.
    ///   - kindOfDrink: ジュースの種類.
    /// - Returns: 指定したジュース. 在庫不足や釣り銭不足で買えなかった場合は nil が返される.
    func buy(payment: Int, kindOfDrink: Int) -> Drink2? {
        // 100円と500円だけ受け付ける
        if (payment != 100) && (payment != 500) {
            charge += payment
            return nil
        }
        
        if (kindOfDrink == Drink2.coke) && (quantityOfCoke == 0) {
            charge += payment
            return nil
        } else if (kindOfDrink == Drink2.dietCoke) && (quantityOfDietCoke == 0) {
            charge += payment
            return nil
        } else if (kindOfDrink == Drink2.tea) && (quantityOfTea == 0) {
            charge += payment
            return nil
        }
        
        // 釣り銭不足
        if payment == 500 && numberOf100Yen < 4 {
            charge += payment
            return nil
        }
        
        if payment == 100 {
            // 100円を釣り銭に変える
            numberOf100Yen += 1
        } else if payment == 500 {
            // 400円のお釣り
            charge += (payment - 100)
            // 100円の釣り銭に変える
            numberOf100Yen -= (payment - 100) / 100
        }
        
        if kindOfDrink == Drink2.coke {
            quantityOfCoke -= 1
        } else if kindOfDrink == Drink2.dietCoke {
            quantityOfDietCoke -= 1
        } else {
            quantityOfTea -= 1
        }
        
        return Drink2(kind: kindOfDrink)
    }
}
