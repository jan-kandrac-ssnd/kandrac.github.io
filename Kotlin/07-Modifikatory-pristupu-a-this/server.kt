package server

import java.net.ServerSocket

fun main() {
    val serverSocket = ServerSocket(9000)
    println("Waiting for client...")
    val clientSocket = serverSocket.accept()
    println("Client connected!")

    val inputStream = clientSocket.getInputStream().bufferedReader()
    val outputStream = clientSocket.getOutputStream().bufferedWriter()

    while(clientSocket.isConnected) {
        println("Waiting for messages!")
        val input = inputStream.readLine()
        println("Received: $input!")
        outputStream.write("${input.uppercase()}\n")
        outputStream.flush()
    }

    // close connection
    inputStream.close()
    outputStream.close()
    serverSocket.close()
    clientSocket.close()
}