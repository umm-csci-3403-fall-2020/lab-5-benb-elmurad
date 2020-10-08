#!/usr/bin/env bats

setup() {
  BATS_TMPDIR=`mktemp --directory`
  cd src
  rm -f echoserver/EchoServer.class
  javac echoserver/*.java
  java echoserver.EchoServer &
  sleep 1
  cd ..
}

teardown() {
  rm -rf "$BATS_TMPDIR"
  kill %1
  # This sleep is crucial to ensure that the server shuts down completely
  # and relinquishes the port before we move on to the next test.
  sleep 1
}

@test "Your client/server pair handles a small bit of text" {
  cd src
  java echoserver.EchoClient < ../test/etc/textTest.txt > "$BATS_TMPDIR"/textTest.txt
  run diff ../test/etc/textTest.txt "$BATS_TMPDIR"/textTest.txt
  cd ..

  [ "$status" -eq 0 ]
}

@test "Your client/server pair handles a large chunk of text" {
  cd src
  java echoserver.EchoClient < ../test/etc/words.txt > "$BATS_TMPDIR"/words.txt
  run diff ../test/etc/words.txt "$BATS_TMPDIR"/words.txt
  cd ..

  [ "$status" -eq 0 ]
}

@test "Your client/server pair handles binary content" {
  cd src
  java echoserver.EchoClient < ../test/etc/pumpkins.jpg > "$BATS_TMPDIR"/pumpkins.jpg
  run diff ../test/etc/pumpkins.jpg "$BATS_TMPDIR"/pumpkins.jpg
  cd ..

  [ "$status" -eq 0 ]
}
