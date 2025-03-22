import Foundation

protocol ObserverNotifiable: Sendable {
    func notify<Observer: Sendable>(
        observers: [Observer],
        _ notification: @Sendable @escaping (Observer) async -> Void
    ) async
}

struct ObserverNotifier: Sendable, ObserverNotifiable {
    func notify<Observer: Sendable>(
        observers: [Observer],
        _ notification: @Sendable @escaping (Observer) async -> Void
    ) async {
        await withTaskGroup(of: Void.self) { group in
            observers.forEach { observer in
                group.addTask {
                    await notification(observer)
                }
            }
        }
    }
}
