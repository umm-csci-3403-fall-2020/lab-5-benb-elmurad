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
			Socket socket = new Socket(server, portNumber);
			
			OutputStream output = socket.getOutputStream();
			while (System.in.read() != null) {
				output.write(System.in.read());
			}
			

			// Grab input stream so we can read from it
			InputStream input = socket.getInputStream();
			while (input.available() > 0) {
				System.out(input.read());
			}

			// close socket when we're done with it
			socket.close();

		} catch (ConnectException ce) {
			System.out.println("We were unable to connect to " + server);
			System.out.println("You should make sure the server is running.");
		} catch (IOException ioe) {
			System.out.println("We caught an unexpected exception");
			System.err.println(ioe);
		}
	}
			
}
