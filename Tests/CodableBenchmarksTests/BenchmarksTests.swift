import XCTest
import Foundation
import CBORCoding
import BinaryCodable
import PotentCBOR
import MessagePacker
import CodableBenchmarks

let count = 10000 // 1, 10, 100, 1000, or 10000
let data = airportsJSON(count: count)

class BenchmarkTests: XCTestCase {
    override class var defaultPerformanceMetrics: [XCTPerformanceMetric] {
        return [
            XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_WallClockTime"),
            XCTPerformanceMetric(rawValue: "com.apple.XCTPerformanceMetric_TransientHeapAllocationsKilobytes")
        ]
    }
    
    override func setUp() {
        assert(false, "The performance tests aren't being run with optimizations on!")
    }
    
    // MARK: Codable
    
    func testCodableDecoding() {
        self.measure {
            let decoder = JSONDecoder()
            let airports = try! decoder.decode([Airport].self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    func testCodableEncoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        
        self.measure {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(airports)
            XCTAssertNotNil(data)
        }
    }
    
    func testCodableSize() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = JSONEncoder()
        let data = try encoder.encode(airports)
        print(size: data.count, for: "Codable")
    }
    
    // MARK: JSONSerialization
    func testJSONSerializationDecoding() {
        self.measure {
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
            let airports = json.map{ Airport(json: $0) }
            XCTAssertEqual(airports.count, count)
        }
    }
    
    func testJSONSerializationEncoding() {
        let airports = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        self.measure {
            let data = try? JSONSerialization.data(withJSONObject: airports)
            XCTAssertNotNil(data)
        }
    }
    
    func testJSONSerializationSize() throws {
        let airports = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        let data = try JSONSerialization.data(withJSONObject: airports)
        print(size: data.count, for: "JSONSerialization")
    }
    
    // MARK: CBOR
    func testCBORDecoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = CBORCoding.CBOREncoder()
        let data = try encoder.encode(airports)
        self.measure {
            let decoder = CBORCoding.CBORDecoder()
            let airports = try! decoder.decode([Airport].self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    func testCBOREncoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        
        self.measure {
            let encoder = CBORCoding.CBOREncoder()
            let data = try? encoder.encode(airports)
            XCTAssertNotNil(data)
        }
    }
    
    func testCBORSize() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = CBORCoding.CBOREncoder()
        let data = try encoder.encode(airports)
        print(size: data.count, for: "CBORCoding")
    }
    
    // MARK: BinaryCodable
    
//    func testBinaryCodableDecoding() throws {
//        let airports = try JSONDecoder().decode([Airport].self, from: data)
//        let encoder = BinaryEncoder()
//        let data = try encoder.encode(airports)
//        self.measure {
//            let decoder = BinaryDecoder()
//            let airports = try! decoder.decode([Airport].self, from: data)
//            XCTAssertEqual(airports.count, count)
//        }
//    }
    
    func testBinaryCodableEncoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        
        self.measure {
            let encoder = BinaryEncoder()
            let data = try? encoder.encode(airports)
            XCTAssertNotNil(data)
        }
    }
    
    func testBinaryCodableSize() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = BinaryEncoder()
        let data = try encoder.encode(airports)
        print(size: data.count, for: "BinaryCodable")
    }
    
    // MARK: PotentCodables
    
    func testPotentCBORDecoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = PotentCBOR.CBOREncoder()
        let data = try encoder.encode(airports)
        self.measure {
            let decoder = PotentCBOR.CBORDecoder()
            let airports = try! decoder.decode([Airport].self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    func testPotentCBOREncoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)

        self.measure {
            let encoder = PotentCBOR.CBOREncoder()
            let data = try? encoder.encode(airports)
            XCTAssertNotNil(data)
        }
    }

    func testPotentCBORSize() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = PotentCBOR.CBOREncoder()
        let data = try encoder.encode(airports)
        print(size: data.count, for: "PotentCBOR")
    }
    
    // MARK: - MessagePacker
    func testMessagePackerDecoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = MessagePackEncoder()
        let data = try encoder.encode(airports)
        self.measure {
            let decoder = MessagePackDecoder()
            let airports = try! decoder.decode([Airport].self, from: data)
            XCTAssertEqual(airports.count, count)
        }
    }
    
    func testMessagePackerEncoding() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)

        self.measure {
            let encoder = MessagePackEncoder()
            let data = try? encoder.encode(airports)
            XCTAssertNotNil(data)
        }
    }

    func testMessagePackerSize() throws {
        let decoder = JSONDecoder()
        let airports = try decoder.decode([Airport].self, from: data)
        let encoder = MessagePackEncoder()
        let data = try encoder.encode(airports)
        print(size: data.count, for: "MessagePacker")
    }
}

extension BenchmarkTests {
    private func print(size: Int, for encoderName: String) {
        Swift.print("\(encoderName) size: \(size) bytes (\(ByteCountFormatter.string(fromByteCount: Int64(size), countStyle: .file)))")
    }
}
