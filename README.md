# Codable Benchmarks

There are a few alternative Codable encoder/decoders out there but suprisingly very little about their performance*.

This repo use a simple test to benchmark encoding, decoding and file size.
 
Benchmarked libraries:

* Swift's own JSON Codable implementation
* [CBORCoding](https://github.com/SomeRandomiOSDev/CBORCoding)
* [BinaryCodable](https://github.com/christophhagen/BinaryCodable)
* [PotentCodables](https://github.com/outfoxx/PotentCodables/)
* [MessagePacker](https://github.com/hirotakan/MessagePacker)
* [Cod](https://github.com/saagarjha/Cod)

Foundation's `JSONSerialization` is also included for comparison.

## Test method

All test encode and decode a list of 100, 1000 and 10000 `Airport` structs. 

```
public struct Airport: Codable {
    let name: String
    let iata: String
    let icao: String
    let coordinates: [Double]
    
    public struct Runway: Codable {
        enum Surface: String, Codable {
            case rigid, flexible, gravel, sealed, unpaved, other
        }
        
        let direction: String
        let distance: Int
        let surface: Surface
    }
    
    let runways: [Runway]
}
```


## Results

Test were ran on a 14'inch M1 MacBook Pro.

| 100 Airports      	| Encoding 	| Decoding | Size          |
|-------------------	|---------:	|---------:|---------------|
| JSONCodable       	|   0.0018 	|   0.0022 | 20492 (20 KB) |
| CBORCoding        	|   0.0033 	|   0.0035 | 14773 (15 KB) |
| BinaryCodable     	|   0.0034 	|  crashes | 15039 (15 KB) |
| PotentCBOR        	|   0.0024 	|   0.0027 | 14773 (15 KB) |
| MessagePacker     	|   0.0014 	|   0.0020 | 14751 (15 KB) |
| Cod             	|   0.0014 	|   0.0012 | 9857 (10 KB)  |
|							|				|          |               |
| JSONSerialization 	|   0.0009 	|   0.0010 | 20492 (20 KB) |


| 1000 Airports     	| Encoding 	| Decoding | Size            |
|-------------------	|---------:	|---------:|-----------------|
| JSONCodable       	|    0.011 	|    0.017 | 209877 (210 KB) |
| CBORCoding        	|    0.020 	|    0.025 | 152655 (153 KB) |
| BinaryCodable     	|    0.026 	|  crashes | 155401 (155 KB) |
| PotentCBOR        	|    0.019 	|    0.022 | 152655 (152 KB) |
| MessagePacker     	|    0.009 	|    0.013 | 152422 (152 KB) |
| Cod               |    0.013  |    0.008 | 102395 (102 KB) |
|							|				|          |                 |
| JSONSerialization 	|    0.006 	|    0.008 | 209877 (210 KB) |

| 10000 Airports    	| Encoding 	| Decoding | Size             |
|-------------------	|---------:	|---------:|------------------|
| JSONCodable       	|    0.088 	|    0.148 | 2084963 (2.1 MB) |
| CBORCoding        	|    0.180 	|    0.233 | 1522226 (1.5 MB) |
| BinaryCodable     	|    0.246 	|  crashes | 1549741 (1.5 MB) |
| PotentCBOR        	|    0.169 	|    0.192 | 1522226 (1.5 MB) |
| MessagePacker     	|    0.069 	|    0.113 | 1519881 (1.5 MB) |
| Cod             	|    0.124 	|    0.063 | 1021610 (1.0 MB) |
|							|				|          |                  |
| JSONSerialization 	|    0.041 	|    0.063 | 2084963 (2.1 MB) |


## License

MIT

## Contact

Paulo [@pfandrade_](https://twitter.com/pfandrade_)
