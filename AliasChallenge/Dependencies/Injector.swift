import Foundation
import Swinject

// MARK: - Dependency injection
enum Injector {
    static let current: Assembler = {
        let container = Container()
        let assambler = Assembler(
            [
                ServiceAssembly()
            ],
            container: container
        )
        return assambler
    }()
}

// MARK: - Extensions
extension Injector {
    static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        let service: Service = current.resolver.resolve(serviceType).unwrap()
        return service
    }
}
