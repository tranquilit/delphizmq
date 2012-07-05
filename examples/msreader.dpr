program msreader;
//
//  Reading from multiple sockets
//  This version uses a simple recv loop
//
{$APPTYPE CONSOLE}

uses
    SysUtils
  , zmqapi
  ;

var
  context: TZMQContext;
  receiver,
  subscriber: TZMQSocket;
  rc: Boolean;
  task,
  update: TZMQMessage;
begin
  //  Prepare our context and sockets
  context := TZMQContext.Create( 1 );

  //  Connect to task ventilator
  receiver := TZMQSocket.Create( context, stPull );
  receiver.connect( 'tcp://localhost:5557' );

  //  Connect to weather server
  subscriber := TZMQSocket.Create( context, stSub );
  subscriber.connect( 'tcp://localhost:5556' );
  subscriber.subscribe( '10001' );

  //  Process messages from both sockets
  //  We prioritize traffic from the task ventilator
  while True do
  begin
    //  Process any waiting tasks
    repeat
      task := TZMQMessage.create;
      try
        rc := receiver.recv( task, [rsfNoBlock] );
      except
        rc := False;
      end;
      if rc then
      begin
        //  process task
      end;
      task.Free;
    until rc;
    //  Process any waiting weather updates
    repeat
      update := TZMQMessage.Create;
      Try
        rc := subscriber.recv( update, [rsfNoBlock] );
      except
        rc := False;
      end;
      if rc then
      begin
        //  process weather update
      end;
      update.Free;
    until rc;
    //  No activity, so sleep for 1 msec
    sleep (1);
  end;
  //  We never get here but clean up anyhow
  receiver.Free;
  subscriber.Free;
  context.Free;
end.
