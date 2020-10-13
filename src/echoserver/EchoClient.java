package echoserver;
import java.net.*;
import java.io.*;

public class EchoClient {
	public static final int portNumber = 6013;

	public static void main(String[] args) throws IOException {
		String server;
		// bother localhost if we aren't given a server
		if (args.length == 0) {
			server = "127.0.0.1";
		} else {
			server = args[0];
		}

		try {
			// connect to server

			// create our socket and input/output streams to it
			Socket socket = new Socket(server, portNumber);
			InputStream input = socket.getInputStream();
			OutputStream output = socket.getOutputStream();

			int echoThisByte; // integer to hold the byte we will be tossing around
			// System.in.read() returns -1 when the steam is done
			while ((echoThisByte = System.in.read()) != -1) {
				// write our byte to the outputstream
				output.write(echoThisByte);
				// send it off to the server
				output.flush();
				// receive byte from server and write to System.out
				System.out.write(input.read());
				// jpg test failing without this => flush the system output so that it doesn't try to write groups of bytes and mess everything up
				System.out.flush();
			}
			// Close all the things we opened now that we're done
			socket.close();
			input.close();
			output.close();
			
			// very basic error handling
		} catch (ConnectException ce) {
			System.out.println("We were unable to connect to " + server);
			System.out.println("You should make sure the server is running.");
		} catch (IOException ioe) {
			System.out.println("We caught an unexpected exception");
			System.err.println(ioe);
		}
	}
			
}
