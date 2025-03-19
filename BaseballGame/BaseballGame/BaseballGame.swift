//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by JIN LEE on 3/17/25.
//

import Foundation

struct BaseballGame {
    func start() {
        let answer = generateRandomNumbers()
        print("""
                🍋 Welcom to LEMONY's Hatch Game 

                [Rules] 
                🐥 = correct number, correct position. 
                🐣 = correct number, wrong position. 
                🥚 = wrong number, wrong position.
            """)
        
    }
    func generateRandomNumbers() -> [Int] {
        
        /**
         Set을 사용해서 만들면?
         
         1. var randomNumbers = Set<Int>()
         2. var randomnumbers: Set<Int> = []
         둘 다 가능. 2번은 Swift 5.1부터 셋 리터럴을 [a, b] 형태로 지원해줘서 빈 셋을 []로 초기화할 수 있다.
         
         while randomNumbers.count < 3 {
         let numbers = Int.random(in: 1...9)
         randomNumbers.insert(numbers)
         }
         
         return Array(randomNumbers)
         -> Set으로 만들었기 때문에 애초에 중복 불가.
         어레이로 만든 코드에 있는 if문 (중복 숫자 제거)이 생략되고, 마지막 리턴 값을 어레이에 다시 담아주는 코드 추가.
         랜덤 숫자 생성 변수 선언시 var, let 둘 다 가능 -> 중복 검사 후 append할 일이 없으므로.
         */

        var randomNumbers: [Int] = []
               
        while randomNumbers.count < 3 {
            var numbers = Int.random(in: 1...9)
            if !randomNumbers.contains(numbers) {
                randomNumbers.append(numbers)
            }
        }
        return randomNumbers
    }
    
    func getUserNumbers() -> [Int]? {
        print ("Please enter 3 different numbers between 1 to 9 ")
        
        guard let userNumbers = readLine() else {
            return nil
        }
        
        var userAnswer = userNumbers.compactMap { Int(String($0)) }
        /**
         1. compactMap = 변환 과정에서 생성된 옵셔널 값들 중 nil이 아닌 값만 추출하여 새로운 배열을 만드는 고차함수
         2. Int(String($0)) = 랜덤 넘버 생성 과정에서 Set을 사용 했을 때, Array(Set) 이렇게 어레이 안에 다시 셋을 넣는 형태로 어레이를 변환한 것처럼, readLine()이 String값을 받기 때문에 Int로 변환하려면 Int(String)의 형태로 받아야 함. 단, String($0)의 형태로 사용하는 이유는 띄어쓰기 없이 '123'이라는 문자열이 입력됐을 때, 이 문자열을 각각 문자로 취급했다가 다시 문자열로 변경하기 위함임. Int와 String 둘 다 문자열을 인자로 받는 데이터 타입이기 때문에 별도의 변환은 필요가 없지만, 띄어쓰기를 안 했을 경우를 위해 각각의 문자로 취급했다 다시 문자열로 바꾸는 과정을 넣은 것. 만약 유저에게 꼭 띄어쓰기를 한 채로 (각각 문자로) 받는다면  let userAnswer = userNumbers.split(separator: " ").compactMap { Int($0) } 으로 처리하면 되는데, 이는 split()이 이미 문자열 타입이기 때문이다.
         */
        
        guard userAnswer.count == 3 else {
            print("Please enter 3 numbers")
            return nil
        }
        
        guard userAnswer.allSatisfy({ 1...9 ~= $0 }) else {
            print ("Please enter numbers between 1 to 9")
            return nil
        }
        
        guard Set(userAnswer).count == Array(userAnswer).count && Set(userAnswer).count == 3 else {
            print("Please enter 3 different numbers")
            return nil
        }
        
        return userAnswer
    }
}
