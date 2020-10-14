package echoserver;

import java.net.*;
import java.io.*;

public class EchoServer {
  public static final int portNumber = 6013;

  public static void main(String[] args) {
    try {
      // Start listening on the specified port
      ServerSocket sock = new ServerSocket(portNumber);

      // Run forever, which is common for server style services
      while (true) {
        // Wait until someone connects, thereby requesting a date
        Socket client = sock.accept();
        System.out.println("Got a request!");

	    int Bytes;
	    InputStream input = client.getInputStream();
	    OutputStream output = client.getOutputStream();

	    while ((Bytes = input.read()) != -1){
	      output.write(Bytes);
        }

        client.close();
      }

    // Minimal error handling

    } catch (IOException ioe) {
      System.out.println("We caught an unexpected exception");
      System.err.println(ioe);
    }
  }
}
