import Foundation

func airportsJSON(count: Int) -> Data {
    guard let url = Bundle.module.url(forResource: "Fixtures/airports\(count)", withExtension: "json"),
        let data = try? Data(contentsOf: url) else {
        fatalError()
    }
    
    return data
}
