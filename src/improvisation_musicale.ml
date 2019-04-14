let _ =
  begin
    Graphics.open_graph " 400x600";
    Graphics.sound 440 1000;
    Graphics.set_window_title "Hello";
    Graphics.read_key ();
  end