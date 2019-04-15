open Types

(* Play the note *)
let play_note note duration =
  Graphics.sound (Types.note2freq note) duration