import Foundation

struct Stock: Equatable {
    private var quantity: Int
    
    init?(quantity: Int) {
        guard quantity > 0 else {
            return nil
        }

        self.quantity = quantity
    }
    
    func getQuantity() -> Int {
        return quantity
    }
    
    mutating func decrement() {
        quantity -= 1
    }
}

enum CoinWorth: Int {
    case oneHundred = 100
    case fiveHundred = 500
}

struct Coin: Equatable {
    
    private var amount: Int
    
    init?(amount: Int) {
        guard amount > 0 else {
            return nil
        }
        
        self.amount = amount
    }
    
    func getAmount() -> Int {
        return amount
    }
}

enum DrinkType {
    case coke
    case dietCoke
    case tea
}

class Drink2 {
    private let kind: DrinkType

    init(kind: DrinkType) {
        self.kind = kind
    }

    func getKind() -> DrinkType {
        return kind
    }
}

class VendingMachine2 {
    var stockOfCoke = Stock(quantity: 5)
    var stockOfDietCoke = Stock(quantity: 5)
    var stockOfTea = Stock(quantity: 5)
    var numberOf100Yen = [CoinWorth]()
    var charge =  [CoinWorth]()

    /// ジュースを購入する
    /// - Parameters:
    ///   - payment: 投入金額. 100円と500円のみ受け付ける.
    ///   - kindOfDrink: ジュースの種類.
    /// - Returns: 指定したジュース. 在庫不足や釣り銭不足で買えなかった場合は nil が返される.
    func buy(payment: CoinWorth, kindOfDrink: DrinkType) -> Drink2? {
        // 100円と500円だけ受け付ける
        if (payment != CoinWorth.oneHundred) && (payment != CoinWorth.fiveHundred) {
            charge.append(payment)
            return nil
        }
        
        if (kindOfDrink == DrinkType.coke) && (stockOfCoke?.getQuantity() == 0) {
            charge.append(payment)
            return nil
        } else if (kindOfDrink == DrinkType.dietCoke) && (stockOfDietCoke?.getQuantity() == 0) {
            charge.append(payment)
            return nil
        } else if (kindOfDrink == DrinkType.tea) && (stockOfTea?.getQuantity() == 0) {
            charge.append(payment)
            return nil
        }
        
        // 釣り銭不足
        if payment == CoinWorth.fiveHundred && numberOf100Yen.count < 4 {
            charge.append(payment)
            return nil
        }
        
        if payment == CoinWorth.oneHundred {
            // 100円を釣り銭に変える
            numberOf100Yen.append(payment)
        } else if payment == CoinWorth.fiveHundred {
            // 400円のお釣り
            charge.append(contentsOf: calculateChange())
        }
        
        if kindOfDrink == DrinkType.coke {
            stockOfCoke?.decrement()
        } else if kindOfDrink == DrinkType.dietCoke {
            stockOfDietCoke?.decrement()
        } else {
            stockOfTea?.decrement()
        }
        
        return Drink2(kind: kindOfDrink)
    }
    
    private func calculateChange() -> [CoinWorth] {
        var caluculatedCharge = [CoinWorth]()
        for (index, coinWorth) in numberOf100Yen.enumerated() {
            if index < 4 {
                caluculatedCharge.append(coinWorth)
            }
        }
        return caluculatedCharge
    }
}
