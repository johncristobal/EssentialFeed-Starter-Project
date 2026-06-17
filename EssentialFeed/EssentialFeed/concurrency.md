#  Concurrency

### checking

- Uffff, no manches que rollo con replace
find, regular expresion
    class (.*)Tests

replace
    @MainActor
    class $1Tests

Swift Concurrency (async/await) changes how concurrency and asynchrony are expressed, introducing a more linear and readable way to write asynchronous code

UI modules (e.g., the iOS UI target) can default to @MainActor
Non-UI or mixed modules should probably be nonisolated by default

### @MainActor
The @MainActor is a special global actor that ensures all annotated code runs on the main thread. 
- developers relied on tools like DispatchQueue.main.async

Mutex can replace non-compile-time-friendly synchronization techniques, such as DispatchQueues.

================
### Swift continuations & tasks

- The New API
func get(from url: URL) async throws -> (Data, HTTPURLResponse)

- y el cancel asi
let task = Task {
    try await client.get(from: url)
}
task.cancel()

- ahora en vez de wait
await fulfillment(of: [exp], timeout: 1.0)

- protocolos de Apple a veces no incluyen el async, para ello
Task.immediate {
    await...
}

- Before:

let exp = expectation(description: "wait for operation")
sut.perform {
    test(sut)
    exp.fulfill()
}
wait(for: [exp], timeout: 0.1)
After:

await sut.perform {
    test(sut)
}
