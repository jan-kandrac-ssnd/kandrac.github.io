package client

import java.net.Socket

fun main() {
    val socket = Socket("localhost", 9000)

    val outputStream = socket.getOutputStream().bufferedWriter()
    val inputStream = socket.getInputStream().bufferedReader()

    while(socket.isConnected) {
        outputStream.write("${readln()}\n")
        outputStream.flush()
        val receivedMessage = inputStream.readLine()
        println("Received: $receivedMessage")
    }

    outputStream.close()
    inputStream.close()
    socket.close()

}