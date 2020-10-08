#!/usr/bin/env bats

setup() {
  BATS_TMPDIR=`mktemp --directory`
}

teardown() {
  rm -rf "$BATS_TMPDIR"
}

@test "Your server code compiles" {
  cd src
  rm -f echoserver/EchoServer.class
  run javac echoserver/EchoServer.java
  cd ..
  [ "$status" -eq 0 ]
}

@test "Your server starts successfully" {
  cd src
  java echoserver.EchoServer &
  status=$?
  kill %1
  cd ..
  [ "$status" -eq 0 ]
}

@test "Your server handles a small bit of text" {
  cd src
  rm -f echoserver/*.class
  javac echoserver/EchoServer.java
  java echoserver.EchoServer &
  sleep 1
  cd ..

  cd test/sampleBin
  java echoserver.EchoClient < ../etc/textTest.txt > "$BATS_TMPDIR"/textTest.txt
  run diff ../etc/textTest.txt "$BATS_TMPDIR"/textTest.txt
  cd ../..
  kill %1
  [ "$status" -eq 0 ]
}

@test "Your server handles a large chunk of text" {
  cd src
  rm -f echoserver/*.class
  javac echoserver/EchoServer.java
  java echoserver.EchoServer &
  sleep 1
  cd ..

  cd test/sampleBin
  java echoserver.EchoClient < ../etc/words.txt > "$BATS_TMPDIR"/words.txt
  run diff ../etc/words.txt "$BATS_TMPDIR"/words.txt
  cd ../..
  kill %1
  [ "$status" -eq 0 ]
}

@test "Your server handles binary content" {
  cd src
  rm -f echoserver/*.class
  javac echoserver/EchoServer.java
  java echoserver.EchoServer &
  sleep 1
  cd ..

  cd test/sampleBin
  java echoserver.EchoClient < ../etc/pumpkins.jpg > "$BATS_TMPDIR"/pumpkins.jpg
  run diff ../etc/pumpkins.jpg "$BATS_TMPDIR"/pumpkins.jpg
  cd ../..
  kill %1
  [ "$status" -eq 0 ]
}
