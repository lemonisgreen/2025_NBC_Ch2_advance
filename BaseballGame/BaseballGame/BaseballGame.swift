//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by JIN LEE on 3/17/25.
//

import Foundation

class BaseballGame {
    
    var gameHistory: [(Int, Int)] = []
    var gameRunningCount = 0
    var compareNumberCount = 0
    
    func start() {
        var systemRunning = true
        
        while systemRunning {
        // 조건에 따라 언제 끝날지 모르니까... while문 쓰기
            
        print("""
            
                🍋 Welcom to LEMONY's Hatch Game 
                Your mission: Decode the 3-digit secret number to hatch the eggs!
            
                [Rules] 
                  
                Enter 3 different numbers between 0 and 9 until all the eggs are hatched.
                ** Notice! The secret code does not start with 0(zero) **
            
                🐥 = correct number, correct position. 
                🐣 = correct number, wrong position. 
                🥚 = wrong number, wrong position.
                ** Notice! The position of the eggs is not related to the position of the numbers.
            
                ---------------------------------------------------------------------------------
                1. START GAME  2. GAME HISTORY  3. EXIT GAME
            
            """)
            
            print("Please select option number.")
            guard let selectedOptionNumber = readLine() else { continue } // 마찬가지로 원하는 옵션 넘버를 못 받으면 다시 돌아감
            
            switch selectedOptionNumber {
            case "1":
                gameRunningCount += 1 // 게임 시작시 게임 횟수 카운트
                compareNumberCount = 0 // 게임 내부에서의 시도 횟수는 초기화
                
                var gameRunning = true
                print("Welcome to the Hatch Game! 🥚🐣🐥")
                let randomNumbers = generateRandomNumbers()
                //system과 game 분리를 안 해주면 게임 중간에 다시 system으로 넘어가서 초기 옵션 값을 선택하라는 문구가 나옴,,!! while루프 구분
                
                while gameRunning {
                guard let userAnswer = getUserNumbers() else { continue } // 원하는 유저 앤서를 못 받으면 다시 while의 처음으로 돌아가는 코드
                let result = compareNumbers(randomNumbers: randomNumbers, userAnswer: userAnswer)
                print(result)
                
                if userAnswer == randomNumbers {
                    print("congratulations! All eggs hatched. Quit the game and go to the main.")
                
                    gameHistory.append((gameRunningCount, compareNumberCount))
                    gameRunning = false
                }
            }
                
            case "2":
                if gameRunningCount == 0 {
                    print("\n\n=== HISTORY ===\n\n")
                    print("No game history.")
                    print("\n\n================\n\n")
                } else {
                    for (gameRunningCount, compareNumberCount) in gameHistory {
                        print("\n\n=== HISTORY ===\n\n")
                        print("Game No.\(gameRunningCount), Attempt number: \(compareNumberCount)")
                        print("\n\n================\n\n")
                    }
                }

            case "3":
                print("Are you sure? This will delete all game history.\nif you're really sure, press 'yes' \nor if not, press any key")
                guard let userChoose = readLine() else { continue }
                if userChoose == "yes" {
                    print("Exiting the Hatch Game. Goodbye! 🐥🐣🥚")
                    systemRunning = false
                } else {
                    
                }
                
            default:
                print("Please enter the correct number.")
            }
        }
    }
    
    func generateRandomNumbers() -> [Int] {
        var randomNumbers: [Int] = []
        
        randomNumbers.append(Int.random(in: 1...9))
        // 미리 랜덤 넘버스 바구니에 0을 뺀 랜덤 숫자 하나 담고 시작
        
        while randomNumbers.count < 3 {
            var numbers = Int.random(in: 0...9)
            if !randomNumbers.contains(numbers) {
                randomNumbers.append(numbers)
            }
        }
        return randomNumbers
        
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
    }
    
    
    func getUserNumbers() -> [Int]? {
        print ("Please enter 3 different numbers between 0 and 9 ")
        
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
        // .allSatisty = collection 타입에서 컬렉션의 모든 요소가 주어진 조건을 만족하느냐 ~= 패턴매칭연산자. 주로 switch문에서 사용되며, 특정 값이 범위 내에 포함되어 있는지 확인할 때 씀
        guard userAnswer.allSatisfy({ 0...9 ~= $0 }) else {
            print ("Please enter numbers between 0 and 9")
            return nil
        }
        
        guard userAnswer[0] != 0 else {
            print ("Notice! The secret code does not start with 0(zero) Try again")
            return nil
        }
        
        guard Set(userAnswer).count == Array(userAnswer).count && Set(userAnswer).count == 3 else {
            print("Please enter 3 different numbers")
            return nil
        }
        
        return userAnswer
    }
    
    func compareNumbers(randomNumbers: [Int], userAnswer: [Int]) -> String {
        var fullHatch = 0
        var halfHatch = 0
        var unhatch = 0
        
        for i in 0..<3 {
            if randomNumbers[i] == userAnswer[i] {
                fullHatch += 1
            } else if randomNumbers.contains(userAnswer[i]) {
                halfHatch += 1
            } else if !randomNumbers.contains(userAnswer[i]) {
                unhatch += 1
            }
        }
        
        compareNumberCount += 1
        
        return String(repeating: "🐥", count: fullHatch) + String(repeating: "🐣", count: halfHatch) + String(repeating: "🥚", count: unhatch)
        + "\nAttempt number: \(compareNumberCount)"
    }
}
