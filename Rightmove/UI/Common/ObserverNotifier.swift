import Foundation

struct ObserverNotifier<Observer: Sendable> {
    private let observers: [Observer]
    
    init(observers: [Observer]) {
        self.observers = observers
    }
    
    func notify(_ notification: @Sendable @escaping (Observer) async -> Void) async {
        await withTaskGroup(of: Void.self) { group in
            observers.forEach { observer in
                group.addTask {
                    await notification(observer)
                }
            }
        }
    }
}
