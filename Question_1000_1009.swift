//
//  Question_1000_1009.swift
//  Baekjoon_1000
//
//  Created by Sean Kim on 2022/03/26.
//
// 입력 받아오기 = var test : [Int] = InputAll().keyReadLine(inputString: readLine())
// 다른 배열의 값 땡겨올때는 append 의 contentsOf 가 유용

import Foundation

struct Question {
    func Hello(){
        print("Hello")
    }
// MARK: - Question 1000
    func Q1000() {
        let inputNum : [Int] = InputAll().keyReadLine(inputString: readLine())
        if inputNum[0] > 0 && inputNum[1] > 0 && inputNum[0] < 10 && inputNum[1] < 10 {
            let c = inputNum[0] + inputNum[1]
            print("\(c)")
        }
    }
        
// MARK: - Question 1001
    func Q1001() {
        let inputNum : [Int] = InputAll().keyReadLine(inputString: readLine())
        if inputNum[0] > 0 && inputNum[1] > 0 && inputNum[0] < 10 && inputNum[1] < 10 {
            let c = inputNum[0] - inputNum[1]
            print("\(c)")
        }
    }
    
// MARK: - Question 1002
        // A 와 B 의 좌표가 주어지고 각각 A, B 에서 C 까지의 거리도 주어질때 C의 좌표를 구할 수 있는 경우의 수를 구하라 (무한대의 경우 -1 표기)
        // 입력 1 : 테스트 케이스의 갯수
        // 입력 2 : x1, y1, r1, x2, y2, r2
    /*
        가정
            두 원의 크기가 다르고 두 원의 중심점이 일치않는다고 할때
            작은 원의 중심점 = (x1, y1), 큰 원의 중심점 = (x2, y2)
            작은 원의 반지름 = r, 큰 원의 반지름 = r', 두 중심점 간의 거리 = d
     
        풀이
            이문제는 중심점에서 r 또는 r' 의 반지름을 가진 두 원의 위치관계에 대한 코드다
            두 원이 접할때 경우의 수는 접하지 않거나, 2점에서 접하거나, 1점에서 접하거나(내접, 외접), 동심원인 경우다. = 2,1,0,-1
        
        해설
            두 원 중심점 간의 거리 구하는 방법
                x = (x1 - x2) -> if x < 0 { x * -1 }
                y = (y1 - y2) -> if y < 0 { y * -1 }
                d^2 = x^2 + y^2
            2점에서 접하는 경우 -> 출력 2
                d < r + r' and r' - r < d and r' - r > 0
            1점에서 접하는 경우 -> 출력 1
                외접 : d = r + r'
                내접 : d = r' - r
            동일할 경우 -> 출력 -1
                d = 0
            만나지 않는 경우 -> 출력 0
                작은원이 내부에 존재 : d < r' - r
                작은원이 외부에 존재 : d > r' + r
        중요
            제일 중요한건 저런게 아님 과연 부동소수점을 사용하지 않거나 부동소수점의 오차를 잡을 수 있는 코드를 짜냐 못짜냐의 차이같음
            즉, 루트 값을 어떻게 구하냐는 거임
            제곱근 구하는 코드는 sqrt()
    */
    
    func Q1002() {
        let inputNum : [Int] = InputAll().keyReadLine(inputString: readLine())
        var inputArray : [Int] = []
        
        for _ in 0 ..< inputNum[0] {
            inputArray.append(contentsOf: InputAll().keyReadLine(inputString: readLine()))
        }
        
        // 0: caseNum, 1: x1, 2: y1, 3: r1, 4: x2, 5: y2, 6: r2
        
        for _ in 0 ..< inputNum[0] {
            let (x1, y1, r1, x2, y2, r2) = (inputArray[0], inputArray[1], inputArray[2], inputArray[3], inputArray[4], inputArray[5])
            let x = x1 - x2
            let y = y1 - y2
            
//            print(inputArray)
            inputArray.removeSubrange(0...5)
//            print("remove: \(inputArray)")
            
            let d = sqrt(Double((x*x)+(y*y)))
            
            
            if x1 == x2 && y1 == y2 && r1 == r2 { // 정확히 일치
                print(-1)
            } else if Double(abs(r1+r2)) > d && Double(abs(r1-r2)) < d { // 두점에서 만남
                print(2)
            } else if Double(abs(r1+r2)) == d || Double(abs(r1-r2)) == d{ // 한점에서 만남
                print(1)
            } else { // 그 외의 경우
                print(0)
            }
        }
    }
// MARK: - Question 1003
    /*
     동적 계획법(DP)을 사용해서 풀어야 하는 문제
     동일한 계산을 반복할 때 이전에 계산한 값을 메모리에 저장하여 반복 수행을 제거해 프로그램 실행 속도를 올리는 방법
     ps. 분할정복 방법도 있는데 귁 정렬, 합병 정렬 등에 사용됨 -> 문제를 잘게 쪼개서 가장 작은 단위로 분할 해결하는건 DP 와 동일하지만
        작은 단위 쪼개진 문제들은 상위 문제 해결에 재사용하지 않고 메모리제이션 기법 사용 안함
     
     문제 : 피보나치 수열 구하기
     피보나치 수열
        input == 0 :
            return 0
        input == 1 :
            return 1
        input == n :
            return fibonacci(n-1) + fibonacci(n-2)
     출력
        각 테스트 케이스마다 0과 1이 출력되는 횟수를 공백으로 구분해 출력
     
     */
    func Q1003(){
        var inputNum : [Int] = InputAll().keyReadLine(inputString: readLine())
        for _ in 0 ..< inputNum[0] {
            inputNum.append(contentsOf: InputAll().keyReadLine(inputString: readLine()))
        }
        for _ in 0 ..< inputNum[0] {
            var fibonacci : [(Int,Int)] = [(1,0), (0,1)]
            if inputNum[1] > 1{
                for i in 2 ... inputNum[1] {
                    let checkZero:Int = fibonacci[i-1].0 + fibonacci[i-2].0
                    let checkOne:Int = fibonacci[i-1].1 + fibonacci[i-2].1
                    fibonacci.append((checkZero, checkOne))
                }
            }
            print(fibonacci[inputNum[1]].0, fibonacci[inputNum[1]].1)
            inputNum.remove(at: 1)
        }
    }
    
// MARK: - Question 1004
    func Q1004(){
        /*
        Input
            첫 줄 : 테스트 케이스의 개수가 주어짐
            다음 줄 : 각각의 테스트 케이스에 대한 출발점 (x1,y1) 과 도착점 (x2,y2) 이 주어짐
            다음 줄 : 행성계의 개수 n 이 주어짐
            다음 줄 : n 줄에 걸쳐 행성계의 중점과 반지름 (Cx, Cy, r) 이 주어짐
         Output
            각 테스트 케이스에 대해 거쳐야 할 최소의 행성계 진입 / 이탈 횟수를 출력
         제한
            -1000 <= x1, y1, x2, y2, Cx, Cy <= 1000
            1 <= r <= 1000
            1 <= n <= 50
            입력의 모든 값은 정수
         */
        /*
        풀이
            출발점이 어떠한 행성계 안에 있다면 그 행성계를 나오기 위해서 무조건 1번의 이탈이 필요하다.
            도착점이 어떠한 행성계 안에 있다면 그 행성계에 들어가기 위해 무조건 1번의 진입이 필요하다.
            출발점이 포함된 행성계가 다른 행성계 안에 포함되어 있다면 2번의 이탈이 필요하다.
            도착점이 포함된 행성계다 다른 행성계 안에 포함되어 있다면 2번의 진입이 필요하다.
         
            즉, 출발점의 위치를 기반으로 출발점을 포함하고 있는 행성계를 찾는 식으로
         */
        
        let testCaseNum : [Int] = InputAll().keyReadLine(inputString: readLine()) // 일단 테스트 케이스의 갯수를 입력 받음
        for _ in 0 ..< testCaseNum[0] { // 테스트 케이스의 수 만큼 내부 입력을 받음
            let startToEnd : [Int] = InputAll().keyReadLine(inputString: readLine())        // x1, y1, x2, y2 가 들어감
            let (x1, y1, x2, y2) = (startToEnd[0],startToEnd[1],startToEnd[2],startToEnd[3])
            let planetNum : Int = (InputAll().keyReadLine(inputString: readLine()))[0]      // n 이 들어감
//            var planetType : [(Int,Int,Int,Int)] = []                                           // Cx, Cy, r 이 들어감
            var planetType : [Int] = []
            for _ in 0 ..< planetNum {
                let subType: [Int] = InputAll().keyReadLine(inputString: readLine())
                let (cx,cy,r) = (subType[0],subType[1],subType[2])
                let checkStart : Double = sqrt(Double(((cx-x1)*(cx-x1) + (cy-y1)*(cy-y1))))
                let checkEnd : Double = sqrt(Double(((cx-x2)*(cx-x2) + (cy-y2)*(cy-y2))))
//                print("\(checkStart) // \(checkEnd)")
                if checkStart < Double(r) { // 원 안에 있는것 -> 행성계의 경계에 맞닿거나 교차하는 경우는 없으니 = 은 제외
                    if checkEnd < Double(r) {
                        planetType.append(0) // 출발점과 도착점이 같은 행성계에 있다는것을 의미
                    } else {
                        planetType.append(1) // 출발점과 도착점이 다른 행성계에 있다는것을 의미
                    } // if if else EP
                } else { // 일단 출발점은 이 행성계에는 없음
                    if checkEnd < Double(r) {
                        planetType.append(1) // 도착점은 이 행성에 있음
                    } else {
                        planetType.append(0) // 이 행성은 들를 필요가 없음
                    } // if else if else EP
                } // if else Ep
            } // for planetNum EP
            // 이제 planetType 각 요소의 값들을 다 더하면 끝임
            var goToEnd : Int = 0
            for i in 0 ..< planetNum {
                goToEnd += planetType[i]
            } // for i in planetNum EP
            print(goToEnd)
        } // for testCaseNum EP
    } // func EP
// MARK: - Question 1005
    func Q1005(){
        /*
        문제
            건물이 지어지는데는 순서가 있고 건물들은 동시에 건설하는것도 가능함
        Input
            첫째 줄 : 테스트의 개수 t 이 주어짐
            다음 줄 : 건물의 개수 n 과 건물간의 건물순서 규칙의 총 개수 k 가 주어짐 (건물의 번호는 1부터 존재)
            다음 줄 : 각 건물당 걸리는 시간 D1 D2 ... Dn 이 주어짐
            다음 줄 : 건설 순서가 주어짐 -> x y : x 를 지은 다음에 y 를 짓는 것이 가능하다
            마지막 줄 : 승리를 하기 위해 건설해야 할 건물의 번호 w 가 주어짐
        Output
            w 를 건설완료 하는데 드는 최소 시간을 출력
            건설순서는 모든 건물이 건설 가능하도록 주어짐
         제한
            2 ≤ N ≤ 1000
            1 ≤ K ≤ 100,000
            1 ≤ X, Y, W ≤ N
            0 ≤ Di ≤ 100,000, Di는 정수
         예제
            1               -> 테스트 개수 1개
            4 4             -> 건물 4개, 규칙 4개
            10 1 100 10     -> 10초 1초 100초 10초 의 시간이 걸림
            1 2             -> 2번을 짓기 위해선 1번을 지어야 함
            1 3             -> 3번을 짓기 위해선 1번을 지어야 함
            2 4             -> 4번을 짓기 위해선 2번을 지어야 함
            3 4             -> 4번을 짓기 위해선 3번을 지어야 함
            4               -> 지어야 할 건물의 번호는 4
         
            120             -> 결과로 120초가 걸림
         */
        
        /*
        풀이
            다이나믹 프로그래밍, 그래프 이론, 위상 정렬
         */
        let testCaseNum : [Int] = InputAll().keyReadLine(inputString: readLine()) // 일단 테스트 케이스의 갯수를 입력 받음
        
    }
// MARK: - STRUCT END POINT
}
