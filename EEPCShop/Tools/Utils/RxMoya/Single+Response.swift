import Foundation
import RxSwift
import Moya

/// Extension for processing raw NSData generated by network access.
extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {

    /// Filters out responses that don't fall within the given range, generating errors when others are encountered.
    public func filter(statusCodes: ClosedRange<Int>) -> Single<ElementType> {
        return flatMap { response -> Single<ElementType> in
            return Single.just(try response.filter(statusCodes: statusCodes))
        }
    }

    public func filter(statusCode: Int) -> Single<ElementType> {
        return flatMap { response -> Single<ElementType> in
            return Single.just(try response.filter(statusCode: statusCode))
        }
    }

    public func filterSuccessfulStatusCodes() -> Single<ElementType> {
        return flatMap { response -> Single<ElementType> in
            return Single.just(try response.filterSuccessfulStatusCodes())
        }
    }

    public func filterSuccessfulStatusAndRedirectCodes() -> Single<ElementType> {
        return flatMap { response -> Single<ElementType> in
            return Single.just(try response.filterSuccessfulStatusAndRedirectCodes())
        }
    }

    /// Maps data received from the signal into an Image. If the conversion fails, the signal errors.
    public func mapImage() -> Single<Image?> {
        return flatMap { response -> Single<Image?> in
            return Single.just(try response.mapImage())
        }
    }

    /// Maps data received from the signal into a JSON object. If the conversion fails, the signal errors.
    public func mapJSON(failsOnEmptyData: Bool = true) -> Single<Any> {
        return flatMap { response -> Single<Any> in
            return Single.just(try response.mapJSON(failsOnEmptyData: failsOnEmptyData))
        }
    }

    /// Maps received data at key path into a String. If the conversion fails, the signal errors.
    public func mapString(atKeyPath keyPath: String? = nil) -> Single<String> {
        return flatMap { response -> Single<String> in
            return Single.just(try response.mapString(atKeyPath: keyPath))
        }
    }
}
