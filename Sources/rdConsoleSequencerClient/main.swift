import Foundation

print("Welcome to our simple REPL")
let connection = NSXPCConnection(machServiceName: "com.rderik.ConsoleSequencerXPC")
connection.remoteObjectInterface = NSXPCInterface(with: ConsoleSequencerXPCProtocol.self)
connection.resume()

let service = connection.remoteObjectProxyWithErrorHandler { error in
    print("Received error:", error)
} as? ConsoleSequencerXPCProtocol

while true {
  print("Insert text: ", terminator: "")
  let text = readLine(strippingNewline: true)!
  service!.toRedString(text) { (texto) in
    print("from red")
    print(texto, terminator: " ")
  }
  service!.toGreenString(text) { (texto) in
    print(texto)
  }
  if text == "exit" {
    break
  }
}

